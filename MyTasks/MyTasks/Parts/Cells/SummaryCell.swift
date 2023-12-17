//
//  SummaryCell.swift
//  MyTasks
//
//  Created by Richard Van on 16/12/2023.
//

import UIKit
import SnapKit

class SummaryCell: UICollectionViewCell {
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .orange
        view.layer.cornerRadius = 15
        return view
    }()
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        containerView.addSubview(iconImage)
        iconImage.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(32)
            make.height.equalTo(32)
        }
        
        containerView.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImage.snp.centerY)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        containerView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImage.snp.centerY)
            make.leading.equalTo(iconImage.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
    }
    
    func configCell(summaryItem: SummaryItem) {
        iconImage.image = UIImage(systemName: summaryItem.icon)
        titleLabel.text = summaryItem.title
        numberLabel.text = summaryItem.number
    }
}
