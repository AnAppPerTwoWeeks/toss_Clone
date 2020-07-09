//
//  NumberCell.swift
//  refactor
//
//  Created by 장창순 on 08/07/2020.
//  Copyright © 2020 AnAppPerTwoWeeks. All rights reserved.
//

import UIKit

class NumberCell: UICollectionViewCell {
    
    let numberText = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        backgroundColor = . yellow
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        addSubview(numberText)
        numberText.font = UIFont.systemFont(ofSize: 20)
        numberText.textAlignment = .center
        numberText.snp.makeConstraints { (make) in
            make.centerY.centerX.equalToSuperview()
        }
    }
}
