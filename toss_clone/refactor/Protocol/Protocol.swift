//
//  Protocol.swift
//  refactor
//
//  Created by 장창순 on 06/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import Foundation

protocol ButtonActionDelegate: class {
    func sendMoneyButtonPressed()
}

protocol ScrollMenuBarDelegate: class {
    func scrollMenuBar(scrollTo index: Int)
}

protocol PushViewControllerDelegate : class {
    func pushViewController(bankAccount: BankAccount)
}

protocol PopToRootViewControllerDelegate: class {
    func popToRootViewController()
}
