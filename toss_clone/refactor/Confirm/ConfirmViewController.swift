//
//  ConfirmViewController.swift
//  refactor
//
//  Created by 장창순 on 07/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class ConfirmViewController: UIViewController, PopToRootViewControllerDelegate {
    
    let bankImage = UIImageView()
    let descriptionText = UILabel()
    let accountNumber = UILabel()
    let reciever = UILabel()
    let bankListView = UIView()
    let sendButton = UIButton()
    let freeFeeCountText = UILabel()
    let bankImageInBottomView = UIImageView()
    let sendFromBank = UILabel()
    let balance = UILabel()
    let disclosure = UILabel()
    var bankAccount = BankAccount()
    var amountMoney = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    @objc func send() {
        let completeVC = CompleteViewController()
        completeVC.delegate = self
        completeVC.bankAccount = bankAccount
        completeVC.amountMoney = amountMoney
        hidesBottomBarWhenPushed = true
        completeVC.modalPresentationStyle = .fullScreen
        present(completeVC, animated: true)
    }
    
    func popToRootViewController() {
        self.navigationController?.popToRootViewController(animated: false)
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(bankImage)
        bankImage.image = UIImage(named: bankAccount.getBankLogo)
        bankImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.frame.height / 4)
            make.width.height.equalTo(100)
        }
        
        view.addSubview(descriptionText)
        descriptionText.text = "\(bankAccount.getBankName) 계좌로\n\(amountMoney)원을 보냅니다"
        descriptionText.numberOfLines = 0
        descriptionText.textAlignment = .center
        descriptionText.textColor = .black
        descriptionText.font = UIFont(name: "HelveticaNeue-Medium", size: 28)
        descriptionText.snp.makeConstraints { (make) in
            make.top.equalTo(bankImage.snp.bottom).offset(20)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(40)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-40)
        }
        
        view.addSubview(accountNumber)
        accountNumber.text = "\(bankAccount.getAccountNumber)"
        accountNumber.textAlignment = .center
        accountNumber.textColor = UIColor(red: 78/255, green: 89/255, blue: 104/255, alpha: 1.0)
        accountNumber.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        accountNumber.snp.makeConstraints { (make) in
            make.top.equalTo(descriptionText.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(reciever)
        reciever.text = "받는 분 통장 표시: \(bankAccount.getUserName)"
        reciever.font = UIFont(name: "HelveticaNeue", size: 19)
        reciever.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 245/255, alpha: 1.0)
        reciever.layer.cornerRadius  = 15
        reciever.clipsToBounds = true
        reciever.textAlignment = .center
        reciever.textColor = UIColor(red: 66/255, green: 76/255, blue: 92/255, alpha: 1.0)
        reciever.snp.makeConstraints { (make) in
            make.top.equalTo(accountNumber.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
            make.width.equalTo(225)
            make.height.equalTo(45)
        }
        
        view.addSubview(freeFeeCountText)
        freeFeeCountText.text = "수수료 면제 10회 남음"
        freeFeeCountText.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
        freeFeeCountText.textAlignment = .center
        freeFeeCountText.textColor = UIColor(red: 66/255, green: 76/255, blue: 92/255, alpha: 1.0)
        freeFeeCountText.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-5)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(sendButton)
        sendButton.setTitle("보내기", for: .normal)
        sendButton.titleLabel?.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.layer.cornerRadius = 15
        sendButton.backgroundColor = UIColor(red: 49/255, green: 130/255, blue: 246/255, alpha: 1.0)
        sendButton.addTarget(self, action: #selector(send), for: .touchUpInside)
        sendButton.snp.makeConstraints { (make) in
            make.bottom.equalTo(freeFeeCountText.snp.top).offset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-20)
            make.height.equalTo(60)
        }
        
        view.addSubview(bankListView)
        bankListView.backgroundColor = .white
        bankListView.snp.makeConstraints { (make) in
            make.bottom.equalTo(sendButton.snp.top)
            make.left.right.equalToSuperview()
            make.height.equalTo(80)
        }
        
        bankListView.addSubview(disclosure)
        disclosure.text = ">"
        disclosure.font = UIFont(name: "HelveticaNeue", size: 23)
        disclosure.textColor = UIColor(red: 93/255, green: 105/255, blue: 121/255, alpha: 1.0)
        disclosure.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.right.equalTo(bankListView.snp.right).offset(-20)
        }
        
        bankListView.addSubview(bankImageInBottomView)
        bankImageInBottomView.image = UIImage(named: bankAccount.getBankLogo)
        bankImageInBottomView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview().offset(-12)
            make.width.equalTo(20)
            make.height.equalTo(20)
        }
        
        bankListView.addSubview(sendFromBank)
        sendFromBank.text = "\(bankAccount.getBankName)에서 출금"
        sendFromBank.font = UIFont(name: "HelveticaNeue-Medium", size: 19)
        sendFromBank.textColor = .black
        sendFromBank.snp.makeConstraints { (make) in
            make.left.equalTo(bankImageInBottomView.snp.right).offset(15)
            make.centerY.equalToSuperview().offset(-13)
        }
        
        bankListView.addSubview(balance)
        balance.text = "잔액 \(bankAccount.getBalance) 원"
        balance.font = UIFont(name: "HelveticaNeue", size: 17)
        balance.textColor = UIColor(red: 107/255, green: 118/255, blue: 132/255, alpha: 1.0)
        balance.snp.makeConstraints { (make) in
            make.left.equalTo(bankImageInBottomView.snp.right).offset(15)
            make.centerY.equalToSuperview().offset(13)
        }
    }
    
}
