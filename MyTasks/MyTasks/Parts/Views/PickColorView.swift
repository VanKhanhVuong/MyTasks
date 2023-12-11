//
//  PickColorView.swift
//  MyTasks
//
//  Created by Richard Van on 10/12/2023.
//

import UIKit
import SnapKit

class PickColorView: UIView {
    
    var colors: [UIColor] = [
        .systemCyan,
        .systemGreen,
        .systemBlue,
        .systemRed,
        .systemOrange,
        .systemBrown,
        .systemYellow,
        .systemPurple,
        .systemTeal
    ]
    
    private lazy var pickLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    private lazy var pickCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    private func setupUI() {
        addSubview(pickLabel)
        pickLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        addSubview(pickCollectionView)
        pickCollectionView.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(20)
            make.centerY.equalTo(pickLabel.snp.centerY)
            make.right.equalToSuperview()
        }
    }
    
    private func setupDelegate() {
        pickCollectionView.registerCell(ColorCell.self)
        pickCollectionView.delegate = self
        pickCollectionView.dataSource = self
    }
    
    func configView(title: String) {
        self.pickLabel.text = title
    }
}

extension PickColorView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedColor = self.colors[indexPath.item]
        print("Selected color: \(selectedColor)")
    }
}

extension PickColorView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(ColorCell.self, for: indexPath)
        cell.configCell(color: self.colors[indexPath.item])
        return cell
    }
}

extension PickColorView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 15, height: 15)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
    }
}
