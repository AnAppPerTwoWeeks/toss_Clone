//
//  RecipientViewController.swift
//  refactor
//
//  Created by 장창순 on 07/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class RecipientViewController: UIViewController, ScrollMenuBarDelegate, PushViewControllerDelegate {
    
    var amountMoney = ""
    let menuBar = MenuBarView()
    let bottomBorder = CALayer()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.isPagingEnabled = true
        cv.keyboardDismissMode = .interactive
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        dismissKey()
        view.backgroundColor = .white
        navigationItem.title = "\(amountMoney)원 받는 분 입력"
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        menuBar.delegate = self
        
        view.addSubview(menuBar)
        menuBar.snp.makeConstraints { (make) in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        view.addSubview(collectionView)
        collectionView.register(RecentPageCell.self, forCellWithReuseIdentifier: "RecentPageCell")
        collectionView.register(BankListPageCell.self, forCellWithReuseIdentifier: "BankListPageCell")
        collectionView.register(ContactPageCell.self, forCellWithReuseIdentifier: "ContactPageCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(menuBar.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        menuBar.layer.addSublayer(bottomBorder)
        bottomBorder.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1.0).cgColor
        bottomBorder.frame = CGRect(x: 0, y: 59, width: view.frame.size.width, height: 1)
    }
    
    func scrollMenuBar(scrollTo index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        self.collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    func dismissKey() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func pushViewController(bankAccount: BankAccount) {
        let confirmVC = ConfirmViewController()
        confirmVC.bankAccount = bankAccount
        confirmVC.amountMoney = amountMoney
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(confirmVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let itemAt = Int(targetContentOffset.pointee.x / self.view.frame.width)
        let indexPath = IndexPath(item: itemAt, section: 0)
        switch (indexPath.row) {
        case 0:
            menuBar.slideMenuBar.snp.updateConstraints { (make) in make.leading.equalTo(0 * menuBar.frame.width / 3.75 + 20) }
        case 1:
            menuBar.slideMenuBar.snp.updateConstraints { (make) in make.leading.equalTo(1 * menuBar.frame.width / 3.75 + 40) }
        case 2:
            menuBar.slideMenuBar.snp.updateConstraints { (make) in make.leading.equalTo(2 * menuBar.frame.width / 3.75 + 60) }
        default:
            menuBar.slideMenuBar.snp.updateConstraints { (make) in make.leading.equalTo(0 * menuBar.frame.width / 3.75 + 20) }
        }
        
        UIView.animate(withDuration: 0.5, delay: 0.3, usingSpringWithDamping: 1, initialSpringVelocity: 17, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion:nil)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
        }
    }
    
}

extension RecipientViewController: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch (indexPath.row) {
        case 0:
            guard let recentPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentPageCell", for: indexPath) as? RecentPageCell else { return UICollectionViewCell() }
            return recentPageCell
        case 1:
            guard let bankListPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "BankListPageCell", for: indexPath) as? BankListPageCell else { return UICollectionViewCell() }
            bankListPageCell.delegate = self
            return bankListPageCell
        case 2:
            guard let contactPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContactPageCell", for: indexPath) as? ContactPageCell else { return UICollectionViewCell() }
            return contactPageCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
}
