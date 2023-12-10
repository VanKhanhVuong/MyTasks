//
//  HomeViewController.swift
//  MyTasks
//
//  Created by Văn Khánh Vương on 03/11/2023.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var addTaskButton: UIButton!
    
    private var colors: [UIColor] = [
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
    }
    
    private func setupUI() {
        homeCollectionView.backgroundColor = .white
        
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        homeCollectionView.addGestureRecognizer(longPressGesture)
    }
    
    @objc private func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        let gestureLocation = gesture.location(in: homeCollectionView)
        switch gesture.state {
            
        case .began:
            guard let targetIndexPath = homeCollectionView.indexPathForItem(at: gestureLocation) else {
                return
            }
            homeCollectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            homeCollectionView.updateInteractiveMovementTargetPosition(gestureLocation)
        case .ended:
            homeCollectionView.endInteractiveMovement()
        default:
            homeCollectionView.cancelInteractiveMovement()
        }
    }
    
    
    private func setupDelegate() {
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        
        homeCollectionView.register(cellType: TaskCell.self)
    }
    
    private func createTask() {
        let createTaskVC = CreateTaskViewController()
        createTaskVC.modalPresentationStyle = .fullScreen
        self.present(createTaskVC, animated: true)
    }
    
    @IBAction func addTaskTapped(_ sender: Any) {
        createTask()
    }
    
}

extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.item)
        colors.insert(item, at: destinationIndexPath.item)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(with: TaskCell.self, for: indexPath)
        cell.containerView.backgroundColor = self.colors[indexPath.item]
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
