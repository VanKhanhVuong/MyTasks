//
//  HomeViewController.swift
//  MyTasks
//
//  Created by Văn Khánh Vương on 03/11/2023.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    // MARK: Init View
    private lazy var homeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var addTaskButton: UIButton = {
        let button = UIButton()
        button.setTitle("Task", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .red
        return button
    }()
    
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
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        setupAction()
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.left.equalToSuperview()
            $0.width.equalToSuperview()
            $0.height.equalToSuperview().offset(-100)
        }

        view.addSubview(addTaskButton)
        addTaskButton.snp.makeConstraints {
            $0.width.equalTo(200)
            $0.height.equalTo(50)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(homeCollectionView.snp.bottom).offset(10)
        }
    }
    
    private func setupAction() {
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        homeCollectionView.addGestureRecognizer(longPressGesture)
        addTaskButton.addTarget(self, action: #selector(createTask), for: .touchUpInside)
    }
    
    private func setupDelegate() {
        homeCollectionView.delegate = self // Ensure self conforms to UICollectionViewDelegate
        homeCollectionView.dataSource = self // Also set the data source
        homeCollectionView.registerCell(TaskCell.self)
    }
    
    // MARK: Action
    
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
    
    @objc func createTask() {
        let createTaskVC = CreateTaskViewController()
        createTaskVC.modalPresentationStyle = .formSheet
        self.present(createTaskVC, animated: true)
    }
}

// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let item = colors.remove(at: sourceIndexPath.item)
        colors.insert(item, at: destinationIndexPath.item)
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return colors.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(TaskCell.self, for: indexPath)
        cell.containerView.backgroundColor = self.colors[indexPath.item]
        return cell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace: CGFloat = 10 * 3
        let availableWidth = collectionView.frame.width - paddingSpace
        let widthPerItem = availableWidth / 2
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }
}
