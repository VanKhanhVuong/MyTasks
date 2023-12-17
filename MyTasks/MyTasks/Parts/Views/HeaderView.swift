//
//  HeaderView.swift
//  MyTasks
//
//  Created by Richard Van on 14/12/2023.
//

import UIKit
import SnapKit

protocol HeaderViewEvents: AnyObject {
    func tappedLeftButton()
    func tappedRightButton()
}

class HeaderView: UIView {
    
    weak var delegate: HeaderViewEvents?
    
    private lazy var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    private lazy var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        addSubview(leftButton)
        leftButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.height.width.equalTo(40)
        }
        
        addSubview(rightButton)
        rightButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-8)
            make.height.width.equalTo(40)
        }
        
        self.backgroundColor = .white
        titleLabel.textColor = .black
        
        leftButton.setTitleColor(.red, for: .normal)
        leftButton.addTarget(self, action: #selector(onTappedLeftButton), for: .touchUpInside)
        
        rightButton.setTitleColor(.blue, for: .normal)
        rightButton.addTarget(self, action: #selector(onTappedRightButton), for: .touchUpInside)
        
        
        
    }
    
    @objc func onTappedLeftButton() {
        self.delegate?.tappedLeftButton()
    }
    
    @objc func onTappedRightButton() {
        self.delegate?.tappedRightButton()
    }
    
    func configView(titleText: String, leftIcon: String, leftTextButton: String, rightIcon: String, rightTextButton: String) {
        titleLabel.text = titleText
        
        leftButton.setImage(UIImage(systemName: leftIcon), for: .normal)
        leftButton.setTitle(leftTextButton, for: .normal)
        
        rightButton.setImage(UIImage(systemName: rightIcon), for: .normal)
        rightButton.setTitle(rightTextButton, for: .normal)
    }
}
