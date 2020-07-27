//
//  DCSimpleFieldVC.swift
//  DCTextField
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

protocol DCSimpleFieldVCDelegate {
    func toggleOpenCloseField()
}

class DCSimpleFieldVC: UIViewController {

    var titleLabel                  = DCTitleLabel(textAlignment: .left, fontSize: 14)
    var textField                   = DCSimpleTF()
    var fieldLine                   = UIView()
    var isEditingField              = false
    var closeTitleLabelBottom       = NSLayoutConstraint()
    var openTitleLabelBottom        = NSLayoutConstraint()
    var closeTextFieldHeightAnchor  = NSLayoutConstraint()
    var openTextFieldHeightAnchor   = NSLayoutConstraint()
    var closeFieldLineTopAnchor     = NSLayoutConstraint()
    var openFieldLineTopAnchor      = NSLayoutConstraint()
    var delegate:                   DCSimpleFieldVCDelegate?
    let openTextFieldFont           = UIFont.systemFont(ofSize: 40, weight: .medium)
    let closeTextFieldFont          = UIFont.systemFont(ofSize: 18, weight: .heavy)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        layoutUI()
        addTextFieldEvents()
    }
    
    init(title: String, placeHolder: String, isInitialStateEditing: Bool) {
        super.init(nibName: nil, bundle: nil)
        
        
        self.titleLabel.text                    = title
        
        self.textField.attributedPlaceholder    = NSAttributedString(string: "Digite...",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor.systemGray])
        
        self.isEditing                          = isInitialStateEditing
        
        self.textField.resignFirstResponder()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubviews() {
        view.addSubview(titleLabel)
        view.addSubview(textField)
        view.addSubview(fieldLine)
    }
    
    func addTextFieldEvents() {
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeTextFieldFocus)))
        textField.addTarget(self, action: #selector(myTargetEditingDidBeginFunction), for: UIControl.Event.editingDidBegin)
    }
    
    @objc func myTargetEditingDidBeginFunction() {
        toogleFieldEditingAnimation()
    }
    
    @objc func removeTextFieldFocus() {
        textField.resignFirstResponder()
        toogleFieldEditingAnimation()
    }
    
    func layoutUI() {
        fieldLine.translatesAutoresizingMaskIntoConstraints = false
        fieldLine.backgroundColor           = .systemGray
        
        let padding: CGFloat                = 16
        let closeFieldLinePadding: CGFloat  = 5
        let openFieldLinePadding: CGFloat   = 15
        let fontField = isEditing ? openTextFieldFont : closeTextFieldFont
        textField.font = fontField
        textField.textColor = isEditing ? .systemGreen : .black
        textField.tintColor = isEditing ? .systemGreen : .black
        titleLabel.alpha    = isEditing ? 0 : 1
        
        NSLayoutConstraint.activate([
            
            textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: padding),
            
            fieldLine.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            fieldLine.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            fieldLine.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        closeTitleLabelBottom               = titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -5)
        openTitleLabelBottom                = titleLabel.bottomAnchor.constraint(equalTo: textField.topAnchor, constant: -20)
        openTitleLabelBottom.isActive       = isEditing
        closeTitleLabelBottom.isActive      = !isEditing
        closeTextFieldHeightAnchor          = textField.heightAnchor.constraint(equalToConstant: 20)
        openTextFieldHeightAnchor           = textField.heightAnchor.constraint(equalToConstant: 44)
        openTextFieldHeightAnchor.isActive  = isEditing
        closeTextFieldHeightAnchor.isActive = !isEditing
        closeFieldLineTopAnchor             = fieldLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: closeFieldLinePadding)
        openFieldLineTopAnchor              = fieldLine.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: openFieldLinePadding)
        openFieldLineTopAnchor.isActive     = isEditing
        closeFieldLineTopAnchor.isActive    = !isEditing
    }
    
    func toogleFieldEditingAnimation() {
        isEditing.toggle()
        
        self.textField.textColor        = self.isEditing ? UIColor.systemGreen : UIColor.black
        UIView.transition(with: textField, duration: 0.1, options: .transitionCrossDissolve, animations: {
            self.view.layoutIfNeeded()
        })
        
        
        
        UIView.transition(with: titleLabel, duration: 0.3, options: .curveEaseOut, animations:{
            self.titleLabel.alpha           = self.isEditing ? 0 : 1
        })
        
        openTextFieldHeightAnchor.isActive  = isEditing
        closeTextFieldHeightAnchor.isActive = !isEditing
        textField.font                      = isEditing ? openTextFieldFont : closeTextFieldFont
        textField.tintColor                 = isEditing ? .systemGreen : .black
        
        UIView.animate(withDuration: 0.2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
            self.view.layoutIfNeeded()
        })
        
        openTitleLabelBottom.isActive       = isEditing
        closeTitleLabelBottom.isActive      = !isEditing
        openFieldLineTopAnchor.isActive     = isEditing
        closeFieldLineTopAnchor.isActive    = !isEditing
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
            self.view.layoutIfNeeded()
        })

        fieldLine.backgroundColor = isEditing ? .systemGray2: .systemGray
        UIView.animate(withDuration: 0.2, delay: 0.1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations:{
            self.view.layoutIfNeeded()
        })
        
        
    }
    
    private func changeColor(to textColor: UIColor) {
        let changeColor = CATransition()
        changeColor.duration = 0.6
        
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            self.textField.layer.add(changeColor, forKey: nil)
            self.textField.textColor = textColor
        }
        
        CATransaction.commit()
    }
    
}
