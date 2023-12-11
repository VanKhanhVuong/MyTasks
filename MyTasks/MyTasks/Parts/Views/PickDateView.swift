//
//  PickDateView.swift
//  MyTasks
//
//  Created by Richard Van on 10/12/2023.
//

import UIKit
import SnapKit

class PickDateView: UIView {
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var pickDateTime: UIDatePicker = {
        let pickDateTime = UIDatePicker()
        return pickDateTime
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-20)
            make.left.equalToSuperview()
        }

        addSubview(pickDateTime)
        pickDateTime.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.centerY.equalTo(dateLabel.snp.centerY)
            make.right.equalToSuperview()
        }
    }
    
    func configView(title: String) {
        self.dateLabel.text = title
    }
}
