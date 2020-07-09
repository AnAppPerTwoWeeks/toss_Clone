//
//  CompleteViewController.swift
//  refactor
//
//  Created by 장창순 on 07/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class CompleteViewController: UIViewController {
    
    weak var delegate: PopToRootViewControllerDelegate?
    let bankImage = UIImageView()
    let successMessage = UILabel()
    let recieverAccountLabel = UILabel()
    let recieverAccountText = UILabel()
    let dateLabel = UILabel()
    let dateText = UILabel()
    let okButton = UIButton()
    var bankAccount = BankAccount()
    var amountMoney = ""
    var date = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func okButtonPressed() {
        self.delegate?.popToRootViewController()
        self.dismiss(animated: true)
    }
    
    func setupUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        view.backgroundColor = .white
        
        view.addSubview(bankImage)
        bankImage.image = UIImage(named: bankAccount.getBankLogo)
        
        bankImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.frame.height / 4)
            make.width.height.equalTo(100)
        }
        
        view.addSubview(successMessage)
        successMessage.text = "\(amountMoney)원\n송금 완료"
        successMessage.numberOfLines = 0
        successMessage.textAlignment = .center
        successMessage.textColor = .black
        successMessage.font = UIFont(name: "HelveticaNeue-Medium", size: 28)
        
        successMessage.snp.makeConstraints { (make) in
            make.top.equalTo(bankImage.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(40)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-40)
        }
        
        view.addSubview(okButton)
        okButton.setTitle("확인", for: .normal)
        okButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        okButton.setTitleColor(UIColor.white, for: .normal)
        okButton.layer.cornerRadius = 15
        okButton.backgroundColor = UIColor(red: 49/255, green: 130/255, blue: 246/255, alpha: 1.0)
        okButton.addTarget(self, action: #selector(okButtonPressed), for: .touchUpInside)
        
        okButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(60)
        }
        
        view.addSubview(dateLabel)
        dateLabel.text = "날짜"
        dateLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        dateLabel.textColor = UIColor(red: 66/255, green: 76/255, blue: 92/255, alpha: 1.0)
        
        dateLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(okButton.snp.top).offset(-40)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
        }
        
        view.addSubview(recieverAccountLabel)
        recieverAccountLabel.text = "입금 계좌"
        recieverAccountLabel.font = UIFont(name: "HelveticaNeue", size: 18)
        recieverAccountLabel.textColor = UIColor(red: 66/255, green: 76/255, blue: 92/255, alpha: 1.0)
        
        recieverAccountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(dateLabel.snp.top).offset(-20)
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(40)
        }
        
        view.addSubview(dateText)
        dateText.text = getDate()
        dateText.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        dateText.textColor = UIColor(red: 41/255, green: 51/255, blue: 66/255, alpha: 1.0)
        
        dateText.snp.makeConstraints { (make) in
            make.bottom.equalTo(okButton.snp.top).offset(-40)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
        }
        
        view.addSubview(recieverAccountText)
        recieverAccountText.text = "\(bankAccount.bankName) 계좌"
        recieverAccountText.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        recieverAccountText.textColor = UIColor(red: 41/255, green: 51/255, blue: 66/255, alpha: 1.0)
        recieverAccountText.snp.makeConstraints { (make) in
            make.bottom.equalTo(dateText.snp.top).offset(-20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-40)
        }
    }
    
    func getDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월 dd일 HH:MM"
        return dateFormatter.string(from: date)
    }
    
}
