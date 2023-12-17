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
    private lazy var homeScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
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
    
    let headerView = HeaderView()
    let summaryView = SummaryView()
    let taskListView = ListTaskView()
    
    private var taskViewModel = TaskViewModel()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        setupAction()
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(homeScrollView)
        homeScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        homeScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(homeScrollView.snp.edges)
            make.width.equalTo(homeScrollView.snp.width)
        }
        
        contentView.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(50) // Đặt chiều cao của summaryView
        }
        
        contentView.addSubview(summaryView)
        summaryView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(150)
        }
        
        contentView.addSubview(homeCollectionView)
        homeCollectionView.snp.makeConstraints { make in
            make.top.equalTo(summaryView.snp.bottom)
            make.left.right.equalToSuperview()
            make.height.equalTo(700) // Đặt chiều cao của taskListView
            make.bottom.equalToSuperview().priority(.low) // Set ưu tiên thấp để contentView có thể mở rộng đúng chiều cao
        }
        
        
        
        //        view.addSubview(addTaskButton)
        //        addTaskButton.snp.makeConstraints {
        //            $0.width.equalTo(200)
        //            $0.height.equalTo(50)
        //            $0.centerX.equalToSuperview()
        //            $0.top.equalTo(homeCollectionView.snp.bottom).offset(10)
        //        }
        
        
        headerView.configView(titleText: "Home", leftIcon: "", leftTextButton: "", rightIcon: "person.circle", rightTextButton: "")
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
        let item = taskViewModel.taskList.remove(at: sourceIndexPath.item)
        taskViewModel.taskList.insert(item, at: destinationIndexPath.item)
    }
}

// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return taskViewModel.taskList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(TaskCell.self, for: indexPath)
        cell.configure(withTask: taskViewModel.taskList[indexPath.item])
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
