//
//  ViewController.swift
//  Lesson18HW
//
//  Created by Дмитрий Петрушенко on 19/05/2025.
//

import UIKit

class ViewController: UIViewController {
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Enter text"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .default
        textField.returnKeyType = .done
        return textField
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20)
        label.text = "Hello, World!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tap me", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupNotification()
    }
    func setupUI() {
        view.addSubview(textField)
        view.addSubview(label)
        view.addSubview(button)
        
        textField.delegate = self
        
        button.addTarget(self, action: #selector(handleTap), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.centerYAnchor, constant: 10),
            label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 30),
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 30),
            button.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            
            
        ])
    }
    
    func setupNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGesture = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc func keyBoardWillShow(notification: NSNotification) {
        let userInfo = notification.userInfo
        let keyBoardFrame = userInfo![UIResponder.keyboardFrameEndUserInfoKey] as? CGRect
        let keyBoardHeight = keyBoardFrame!.height
        
        let emptySpaceHeight = view.frame.size.height - button.frame.origin.y - button.frame.size.height
        let converedContentHide = keyBoardHeight - emptySpaceHeight
        
        view.frame.origin.y = -converedContentHide
        
    }
    
    @objc func keyBoardWillHide() {
        view.frame.origin.y = 0
    }
    
    @objc func handleTap() {
        label.text = textField.text
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        label.text = textField.text
        return true
    }
}
