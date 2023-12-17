//
//  CreateTaskViewController.swift
//  MyTasks
//
//  Created by Văn Khánh Vương on 03/11/2023.
//

import UIKit
import SnapKit


class CreateTaskViewController: UIViewController {
    
    // MARK: Init View
    private let headerView = HeaderView()
    
    private lazy var contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var taskNameTextField: UITextField = {
        let textField = UITextField()
        textField.configureTextField(
            text: "Enter Title Here",
            font: UIFont.systemFont(ofSize: 25, weight: .semibold),
            textColor: .black,
            placeholderColor: .gray)
        return textField
    }()
    
    private lazy var taskDescTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Task Description"
        textField.configureTextField(
            text: "Description List Here",
            font: UIFont.systemFont(ofSize: 20, weight: .semibold),
            textColor: .black,
            placeholderColor: .gray)
        return textField
    }()
    
    private let pickDateView = PickDateView()
    
    private let pickColorView = PickColorView()
    
    // MARK: viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupDelegate()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    // MARK: Notification Keyboard
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let userInfo = notification.userInfo,
            let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else {
                return
        }
        
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
        contentScrollView.contentInset = contentInsets
        contentScrollView.scrollIndicatorInsets = contentInsets
    }

    @objc func keyboardWillHide(_ notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        contentScrollView.contentInset = contentInsets
        contentScrollView.scrollIndicatorInsets = contentInsets
    }
    
    // MARK: Setup
    private func setupUI() {
        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.top.left.equalToSuperview()
            make.height.equalTo(40)
            make.width.equalToSuperview()
        }
        
        view.addSubview(contentScrollView)
        contentScrollView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom)
            make.left.equalToSuperview()
            make.height.equalToSuperview().offset(-80)
            make.width.equalToSuperview()
        }
    
        contentScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(contentScrollView.snp.top)
            make.left.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalToSuperview().offset(-80)
        }
        
        let views: [UIView] = [taskNameTextField, taskDescTextField, pickDateView, pickColorView]
        
        for (index, view) in views.enumerated() {
            view.tag = 200 + index
            contentView.addSubview(view)
            
            view.snp.makeConstraints { make in
                let currentViewTag = 200 + index - 1
                let currentView = contentView.viewWithTag(currentViewTag)
                
                make.left.equalToSuperview().offset(20)
                make.width.equalToSuperview().offset(-40)
                
                if let prevView = currentView {
                    make.top.equalTo(prevView.snp.bottom).offset(20)
                } else {
                    make.top.equalTo(contentView.snp.top).offset(20)
                }
                make.height.equalTo(50)
            }
        }
        
        headerView.configView(titleText: "Create Task", leftIcon: "", leftTextButton: "Close", rightIcon: "", rightTextButton: "Create")
        headerView.delegate = self
        
        pickDateView.configView(title: "Pick Date:")
        pickColorView.configView(title: "Pick Color:")
        
//        taskDescTextField.snp.makeConstraints { make in
//            make.height.equalTo(100)
//        }
    }
    
    private func setupDelegate() {
        taskNameTextField.delegate = self
        taskDescTextField.delegate = self
    }
}

// MARK: UITextFieldDelegate
extension CreateTaskViewController: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print("TextField should begin editing")
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

// MARK: HeaderViewEvents
extension CreateTaskViewController: HeaderViewEvents {
    func tappedLeftButton() {
        self.dismiss(animated: true)
    }
    
    func tappedRightButton() {
        print("Create task")
    }
}
