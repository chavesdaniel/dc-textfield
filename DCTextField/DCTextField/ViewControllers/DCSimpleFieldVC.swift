//
//  DCSimpleFieldVC.swift
//  DCTextField
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

public enum DCInputTextFieldType {
    case branchWithoutDigit, account, description
}

protocol DCSimpleFieldVCDelegate {
    func toggleOpenCloseField()
}

class DCSimpleFieldVC: UIViewController {

    private var titleLabel                  = DCTitleLabel(textAlignment: .left, fontSize: 14)
    private var textField                   = DCSimpleTF()
    private var fieldLine                   = UIView()
    private var isEditingField              = false
    private var closeTextFieldTopAnchor       = NSLayoutConstraint()
    private var openTextFieldTopAnchor        = NSLayoutConstraint()
    private var closeTextFieldHeightAnchor  = NSLayoutConstraint()
    private var openTextFieldHeightAnchor   = NSLayoutConstraint()
    private var closeFieldLineTopAnchor     = NSLayoutConstraint()
    private var openFieldLineTopAnchor      = NSLayoutConstraint()
    private var delegate:                   DCSimpleFieldVCDelegate?
    private let openTextFieldFont           = UIFont.systemFont(ofSize: 50, weight: .medium)
    private let closeTextFieldFont          = UIFont.systemFont(ofSize: 18, weight: .heavy)
    private var textFieldType:              DCInputTextFieldType!
    private var inputTextMask               = ""
    private var isValid                     = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        addTextFieldEvents()
    }
    
    init(title: String, placeHolder: String, isInitialStateEditing: Bool, inputTextFieldType: DCInputTextFieldType) {
        super.init(nibName: nil, bundle: nil)
        
        self.textFieldType                      = inputTextFieldType
        self.titleLabel.text                    = title
        self.textField.delegate                 = self
        self.textField.attributedPlaceholder    = NSAttributedString(string: placeHolder,
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        self.isEditing                          = isInitialStateEditing
        
        self.textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getValue() -> String? {
        return self.textField.text
    }
    
    private func setMask(for inputType:DCInputTextFieldType) {
        switch inputType {
        case .branchWithoutDigit:
            inputTextMask = "####"
            break
        case .account:
            inputTextMask = "#############"
            break
        case .description:
            break
        }
    }
    
    private func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(fieldLine)
    }
    
    func addTextFieldEvents() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTextFieldFocus)))
    }
    
    @objc private func removeTextFieldFocus() {
        textField.resignFirstResponder()
        toogleFieldEditingAnimation(shoulOpen: false)
    }
    
    private func layoutUI() {
        fieldLine.translatesAutoresizingMaskIntoConstraints = false
        fieldLine.backgroundColor           = .systemGray
        
        let padding: CGFloat                = 16
        let closeFieldLinePadding: CGFloat  = 5
        let openFieldLinePadding: CGFloat   = 15
        let fontField = isEditing ? openTextFieldFont : closeTextFieldFont
        textField.font = fontField
        textField.textColor = isEditing ? .systemGreen : .black
        textField.tintColor = isEditing ? .systemGreen : .black
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: padding),
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            fieldLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            fieldLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            fieldLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        closeTextFieldTopAnchor              = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5)
        openTextFieldTopAnchor               = textField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20)
        openTextFieldTopAnchor.isActive      = isEditing
        closeTextFieldTopAnchor.isActive     = !isEditing
        closeTextFieldHeightAnchor          = textField.heightAnchor.constraint(equalToConstant: 20)
        openTextFieldHeightAnchor           = textField.heightAnchor.constraint(equalToConstant: 55)
        openTextFieldHeightAnchor.isActive  = isEditing
        closeTextFieldHeightAnchor.isActive = !isEditing
        closeFieldLineTopAnchor             = fieldLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: closeFieldLinePadding)
        openFieldLineTopAnchor              = fieldLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: openFieldLinePadding)
        openFieldLineTopAnchor.isActive     = isEditing
        closeFieldLineTopAnchor.isActive    = !isEditing
    }
    
    private func toogleFieldEditingAnimation(shoulOpen: Bool) {
        
        self.textField.textColor            = shoulOpen ? UIColor.systemGreen : UIColor.black
        self.textField.tintColor            = shoulOpen ? UIColor.systemGreen : UIColor.black

        openTextFieldHeightAnchor.isActive  = shoulOpen
        closeTextFieldHeightAnchor.isActive = !shoulOpen
        
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations:{
            self.view.layoutIfNeeded()
        })
        
        self.textField.font = shoulOpen ? self.openTextFieldFont : self.closeTextFieldFont
        
        openTextFieldTopAnchor.isActive     = shoulOpen
        closeTextFieldTopAnchor.isActive    = !shoulOpen
        openFieldLineTopAnchor.isActive     = shoulOpen
        closeFieldLineTopAnchor.isActive    = !shoulOpen
        self.fieldLine.backgroundColor      = shoulOpen ? .systemGray2: .systemGray
        
        self.textField.alpha = shoulOpen ? 0 : 1
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations:{
            self.view.layoutIfNeeded()
            self.textField.alpha = 1
        })
        
    }
}

extension DCSimpleFieldVC:UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if !self.isEditing {
            textField.resignFirstResponder()
            return false
        }
        else {
            return true
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.isEditing = true
        self.toogleFieldEditingAnimation(shoulOpen: isEditing)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.isEditing = false
        textField.resignFirstResponder()
        self.toogleFieldEditingAnimation(shoulOpen: isEditing)
    }
    
    private func validateBranchWithoutDigitValidator(updatedText: String) -> Bool {
        if(updatedText.contains("-")) {
            return false
        }
        if(updatedText.count > self.inputTextMask.count) {
            return false
        }
        return true
    }
}

