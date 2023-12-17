//
//  ColorCell.swift
//  MyTasks
//
//  Created by Richard Van on 10/12/2023.
//

import UIKit
import SnapKit

class ColorCell: UICollectionViewCell {
    
    private lazy var containerView: UIView = {
        let view = UIView()
        return view
    }()

    override var isSelected: Bool {
        didSet {
            updateCellSelection()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.bottom.trailing.leading.equalToSuperview()
        }
        containerView.layoutIfNeeded()
        containerView.layer.cornerRadius = containerView.frame.width / 2
        containerView.layer.masksToBounds = true
        
        containerView.layer.borderWidth = 0
        containerView.layer.borderColor = UIColor.clear.cgColor
    }
    
    func configCell(color: UIColor) {
        containerView.backgroundColor = color
    }
    
    private func updateCellSelection() {
        
        if isSelected {
            containerView.layer.borderWidth = 0.5
            containerView.layer.borderColor = UIColor.blue.cgColor
        } else {
            containerView.layer.borderWidth = 0
            containerView.layer.borderColor = UIColor.clear.cgColor
        }
    }
}
