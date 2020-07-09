//
//  MainViewController.swift
//  refactor
//
//  Created by 장창순 on 06/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, ButtonActionDelegate {
    
    private let tableview = UITableView()
    private let serviceList = Services()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: nil)
    }
    
    private func setupTableView() {
        view.backgroundColor = .white
        tableview.backgroundColor = .clear
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(IntroCell.self, forCellReuseIdentifier: "IntroCell")
        tableview.register(UserCell.self, forCellReuseIdentifier: "UserCell")
        tableview.register(ServiceCell.self, forCellReuseIdentifier: "ServiceCell")
        
        view.addSubview(tableview)
        tableview.snp.makeConstraints { (make) in
            make.leading.trailing.top.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func sendMoneyButtonPressed() {
        let NumberPadVC = NumberPadViewController()
        hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(NumberPadVC, animated: true)
        hidesBottomBarWhenPushed = false
    }
}

//MARK: - 테이블뷰 델리게이트 , 데이타소스 
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
        case 0,1:
            return 1
        default:
            return serviceList.listCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch (indexPath.section) {
        case 0:
            guard let introCell = tableview.dequeueReusableCell(withIdentifier: "IntroCell", for: indexPath) as? ServiceCell else { return UITableViewCell() }
            return introCell
        case 1:
            guard let userCell = tableview.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserCell else { return UITableViewCell() }
            userCell.delegate = self
            return userCell
        default:
            guard let serviceCell = tableview.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath) as? ServiceCell else { return UITableViewCell() }
            serviceCell.serviceText.text = "\(serviceList.getServiceAt(indexPath.row))"
            return serviceCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section) {
        case 0:
            return 360
        case 1:
            return 100
        default:
            return 80
        }
    }
    
}
