//
//  SummaryView.swift
//  MyTasks
//
//  Created by Richard Van on 16/12/2023.
//

import UIKit
import SnapKit

protocol SummaryViewEvents: AnyObject { }

class SummaryView: UIView {
    
    weak var delegate: SummaryViewEvents?
    
    private let summaryArr:[SummaryItem] = [
        SummaryItem(icon: "calendar", title: "Today", number: "0"),
        SummaryItem(icon: "tray.circle", title: "All", number: "0"),
        SummaryItem(icon: "checkmark.circle.fill", title: "Done", number: "0"),
        SummaryItem(icon: "exclamationmark.transmission", title: "Miss", number: "0")
    ]
    
    // MARK: Init View
    private lazy var summaryCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupDelegate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupUI() {
        addSubview(summaryCollectionView)
        summaryCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDelegate() {
        summaryCollectionView.delegate = self
        summaryCollectionView.dataSource = self
        summaryCollectionView.registerCell(SummaryCell.self)
    }
}

// MARK: UICollectionViewDelegate
extension SummaryView: UICollectionViewDelegate { }

// MARK: UICollectionViewDataSource
extension SummaryView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(SummaryCell.self, for: indexPath)
        cell.configCell(summaryItem: self.summaryArr[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return summaryArr.count
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SummaryView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = 10 * 3
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        
        return CGSize(width: widthPerItem, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
    }
}
