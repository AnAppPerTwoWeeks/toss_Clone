//
//  NumberPadViewController.swift
//  refactor
//
//  Created by 장창순 on 08/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class NumberPadViewController: UIViewController {
    
    let numberPad = [["1","2","3"],["4","5","6"],["7","8","9"],["취소","0","<-"]]
    let autoTransferButton = UIButton()
    let sendButton = UIButton()
    let sendButtonStackView = UIStackView()
    var buttonArray = [UIButton]()
    let verticalNumberStackView = UIStackView()
    var buttonTag = 0
    var currentNumber = UILabel()
    var wonLabel = UILabel()
    var currentNumberStackView = UIStackView()
    var numberObservation = [NSKeyValueObservation]()
    var numberModel = Number()
    let warningMessage = UILabel()
    let changeMaxAmount = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        updateNumberLabel()
    }
    
    func setupUI() {
        navigationItem.title = "금액을 입력하세요"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .camera, target: self, action: nil)
        view.backgroundColor = .white
        
        autoTransferButton.setTitle("자동이체", for: .normal)
        autoTransferButton.titleLabel?.font = autoTransferButton.titleLabel?.font.withSize(20)
        autoTransferButton.setTitleColor(UIColor(red: 49/255, green: 129/255, blue: 245/255, alpha: 1.0), for: .normal)
        autoTransferButton.layer.cornerRadius = 15
        autoTransferButton.backgroundColor = UIColor(red: 229/255, green: 239/255, blue: 253/255, alpha: 1.0)
        autoTransferButton.alpha = 0.5
        autoTransferButton.isUserInteractionEnabled = false
        
        sendButton.setTitle("송금", for: .normal)
        sendButton.titleLabel?.font = sendButton.titleLabel?.font.withSize(20)
        sendButton.setTitleColor(UIColor.white, for: .normal)
        sendButton.layer.cornerRadius = 15
        sendButton.backgroundColor = UIColor(red: 49/255, green: 130/255, blue: 246/255, alpha: 1.0)
        sendButton.addTarget(self, action: #selector(sendMoney), for: .touchUpInside)
        sendButton.alpha = 0.5
        sendButton.isUserInteractionEnabled = false
        
        sendButtonStackView.addArrangedSubview(autoTransferButton)
        sendButtonStackView.addArrangedSubview(sendButton)
        sendButtonStackView.axis = .horizontal
        sendButtonStackView.distribution = .fillEqually
        sendButtonStackView.spacing = 10
        
        view.addSubview(sendButtonStackView)
        sendButtonStackView.snp.makeConstraints { (make) in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-10)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(20)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).inset(20)
            make.height.equalTo(60)
        }
        
        view.addSubview(verticalNumberStackView)
        verticalNumberStackView.axis = .vertical
        verticalNumberStackView.alignment = .fill
        verticalNumberStackView.distribution = .fillEqually
        verticalNumberStackView.snp.makeConstraints { (make) in
            make.leading.equalTo(view.safeAreaLayoutGuide.snp.leading).offset(20)
            make.trailing.equalTo(view.safeAreaLayoutGuide.snp.trailing).offset(-20)
            make.height.equalTo(view.frame.height / 3)
            make.bottom.equalTo(sendButtonStackView.snp.top).offset(-20)
        }
        
        
        view.addSubview(currentNumberStackView)
        currentNumberStackView.axis = .horizontal
        currentNumberStackView.alignment = .center
        currentNumberStackView.distribution = .fillProportionally
        currentNumberStackView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(view.frame.height / 3.25)
        }
        currentNumberStackView.addArrangedSubview(currentNumber)
        currentNumberStackView.addArrangedSubview(wonLabel)
        currentNumber.text = "0"
        wonLabel.text = "원"
        currentNumber.textColor = UIColor(red: 38/255, green: 48/255, blue: 63/255, alpha: 1.0)
        currentNumber.font = UIFont(name: "HelveticaNeue", size: 45)
        wonLabel.font = UIFont(name: "HelveticaNeue", size: 45)
        wonLabel.textColor = UIColor(red: 38/255, green: 48/255, blue: 63/255, alpha: 1.0)
        
        
        view.addSubview(warningMessage)
        warningMessage.text = "최대 200만원까지 입력할 수 있습니다"
        warningMessage.textColor = UIColor(red: 228/255, green: 41/255, blue: 57/255, alpha: 1.0)
        warningMessage.font = UIFont(name: "HelveticaNeue", size: 15)
        warningMessage.isHidden = true
        warningMessage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.top.equalTo(currentNumberStackView.snp.bottom).offset(10)
        }
        
        view.addSubview(changeMaxAmount)
        changeMaxAmount.setTitle("2,000,000원으로 변경", for: .normal)
        changeMaxAmount.titleLabel?.font = changeMaxAmount.titleLabel?.font.withSize(14)
        changeMaxAmount.setTitleColor(UIColor(red: 78/255, green: 89/255, blue: 104/255, alpha: 1.0), for: .normal)
        changeMaxAmount.layer.cornerRadius = 5
        changeMaxAmount.backgroundColor = UIColor(red: 242/255, green: 243/255, blue: 243/255, alpha: 1.0)
        changeMaxAmount.isHidden = true
        changeMaxAmount.isUserInteractionEnabled = false
        changeMaxAmount.addTarget(self, action: #selector(setMaxAmount), for: .touchUpInside)
        changeMaxAmount.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.equalTo(30)
            make.width.equalTo(150)
            make.top.equalTo(warningMessage.snp.bottom).offset(5)
        }
        
        createNumberButtons()
    }
    
    @objc func setMaxAmount() {
        self.numberModel.setMaxNum("2000000")
    }
    
    func setButtonsAlphaAndInteraction(numberAlpha: CGFloat, buttonAlpha: CGFloat, bool: Bool) {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
            self.sendButton.alpha = buttonAlpha
            self.autoTransferButton.alpha = buttonAlpha
            self.buttonArray[9].alpha = numberAlpha
            self.buttonArray[11].alpha = numberAlpha
            self.sendButton.isUserInteractionEnabled = bool
            self.autoTransferButton.isUserInteractionEnabled = bool
            self.buttonArray[9].isUserInteractionEnabled = bool
            self.buttonArray[11].isUserInteractionEnabled = bool
        }, completion: nil)
        
    }
    
    func updateNumberLabel() {
        let numberObserver = numberModel.observe(\.currentNumber, options: .new) { (number, change) in
            
            UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations: {
                switch number.currentNumber {
                case "0":
                    self.currentNumber.text = "0"
                    self.setButtonsAlphaAndInteraction(numberAlpha: 0, buttonAlpha: 0.5, bool: false)
                default:
                    self.setButtonsAlphaAndInteraction(numberAlpha: 1, buttonAlpha: 1, bool: true)
                    if Int(number.currentNumber)! > 2000001 {
                        self.currentNumber.text = self.commaForNumber(number.currentNumber)
                        self.warningMessage.isHidden = false
                        self.changeMaxAmount.isHidden = false
                        self.sendButton.alpha = 0.5
                        self.autoTransferButton.alpha = 0.5
                        self.sendButton.isUserInteractionEnabled = false
                        self.autoTransferButton.isUserInteractionEnabled = false
                        self.currentNumber.shake()
                        self.wonLabel.shake()
                    } else {
                        self.currentNumber.text = self.commaForNumber(number.currentNumber)
                        self.changeMaxAmount.isUserInteractionEnabled = true
                        self.warningMessage.isHidden = true
                        self.changeMaxAmount.isHidden = true
                    }
                }
            }, completion: nil)
        }
        numberObservation.append(numberObserver)
    }
    
    func createNumberButtons() {
        for row in 0 ..< 4 {
            var buttons = [UIButton]()
            for col in 0..<3 {
                let numberButton = UIButton()
                numberButton.tag = buttonTag
                numberButton.setTitle("\(numberPad[row][col])", for: .normal)
                numberButton.addTarget(self, action: #selector(addNumber), for: .touchUpInside)
                switch buttonTag {
                case 9,11:
                    numberButton.titleLabel?.font = numberButton.titleLabel?.font.withSize(18)
                    numberButton.setTitleColor(UIColor(red: 107/255, green: 118/255, blue: 132/255, alpha: 1.0), for: .normal)
                    numberButton.alpha = 0
                    numberButton.isUserInteractionEnabled = false
                default:
                    numberButton.titleLabel?.font = numberButton.titleLabel?.font.withSize(30)
                    numberButton.setTitleColor(UIColor(red: 38/255, green: 48/255, blue: 63/255, alpha: 1.0), for: .normal)
                }
                buttons.append(numberButton)
                buttonArray.append(numberButton)
                buttonTag += 1
            }
            let horizontalNumberStackView = UIStackView(arrangedSubviews: buttons)
            horizontalNumberStackView.alignment = .fill
            horizontalNumberStackView.axis = .horizontal
            horizontalNumberStackView.distribution = .fillEqually
            verticalNumberStackView.addArrangedSubview(horizontalNumberStackView)
        }
    }
    
    @objc func addNumber(_ sender: UIButton) {
        switch sender.tag {
        case 9,11:
            numberModel.updateNumber(sender.tag)
        default:
            if Int(numberModel.currentNumber)! > 2000001 {
                currentNumber.shake()
                wonLabel.shake()
            } else {
                numberModel.updateNumber(sender.tag)
            }
        }
    }
    
    @objc func sendMoney() {
        let recipientVC = RecipientViewController()
        guard let money = currentNumber.text else { return }
        recipientVC.amountMoney = money
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(recipientVC, animated: true)
    }
    
    func commaForNumber(_ number: String) -> String {
        var result = NSNumber()
        guard let value = Int(number) else { return "Error" }
        result = value as NSNumber
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        
        guard let resultValue = formatter.string(from: result) else { return "Error" }
        return resultValue
    }
    
    deinit {
        numberObservation.removeAll()
    }
}

