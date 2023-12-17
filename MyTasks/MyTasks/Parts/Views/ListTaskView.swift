//
//  ListTaskView.swift
//  MyTasks
//
//  Created by Richard Van on 16/12/2023.
//

import UIKit
import SnapKit

protocol ListTaskViewEvents: AnyObject { }

class ListTaskView: UIView {
    
    weak var delegate: ListTaskViewEvents?
    private var taskViewModel = TaskViewModel()
    
    private lazy var listTaskTableView: UITableView = {
        let tableView = UITableView()
        return tableView
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
        addSubview(listTaskTableView)
        listTaskTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupDelegate() {
        listTaskTableView.delegate = self
        listTaskTableView.dataSource = self
        listTaskTableView.registerCell(TaskListCell.self)
    }
}

extension ListTaskView: UITableViewDelegate { }

extension ListTaskView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskViewModel.taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueCell(TaskListCell.self, for: indexPath)
        cell.configUI(withTask: taskViewModel.taskList[indexPath.row])
        return cell
    }
}
