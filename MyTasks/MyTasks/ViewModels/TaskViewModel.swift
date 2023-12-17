//
//  TaskViewModel.swift
//  MyTasks
//
//  Created by Richard Van on 16/12/2023.
//

import Foundation

protocol TaskViewModelEvent: AnyObject { }

class TaskViewModel {
    weak var delegate: TaskViewModelEvent?
    
    var taskList: [Task] = [
        Task(title: "Task 1", description: "Des 2", date: Date(), priorityColor: "Cyan"),
        Task(title: "Task 2", description: "Des 2", date: Date(), priorityColor: "Green"),
        Task(title: "Task 3", description: "Des 2", date: Date(), priorityColor: "Blue"),
        Task(title: "Task 4", description: "Des 2", date: Date(), priorityColor: "Red"),
        Task(title: "Task 5", description: "Des 2", date: Date(), priorityColor: "Orange"),
        Task(title: "Task 6", description: "Des 2", date: Date(), priorityColor: "Brown"),
        Task(title: "Task 7", description: "Des 2", date: Date(), priorityColor: "Yellow"),
        Task(title: "Task 8", description: "Des 2", date: Date(), priorityColor: "Purple"),
        Task(title: "Task 9", description: "Des 2", date: Date(), priorityColor: "Teal")
    ]
}
