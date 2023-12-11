//
//  UICollectionView+Extension.swift
//  MyTasks
//
//  Created by Richard Van on 10/12/2023.
//

import UIKit

extension UICollectionView {
    
    func registerCell<T: UICollectionViewCell>(_ cellClass: T.Type) {
        let reuseIdentifier = String(describing: cellClass)
        self.register(cellClass, forCellWithReuseIdentifier: reuseIdentifier)
    }
    
    func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        let reuseIdentifier = String(describing: cellClass)
        guard let cell = self.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue cell with identifier: \(reuseIdentifier)")
        }
        return cell
    }
}

