//
//  ViewController.swift
//  DCTextField
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let branchFieldContainerVIew        = UIView()
    let dcBranchController              = DCSimpleFieldVC(title: "Agência", placeHolder: "Digite...", isInitialStateEditing: true, inputTextFieldType: DCInputTextFieldType.branchWithoutDigit)
    
    let accountFieldContainerVIew       = UIView()
    let dcAccountController             = DCSimpleFieldVC(title: "Conta", placeHolder: "Digite...", isInitialStateEditing: false, inputTextFieldType: DCInputTextFieldType.account)
    
    let valueFieldContainerVIew         = UIView()
    let dcValueController               = DCSimpleFieldVC(title: "O valor de", placeHolder: "0,00", isInitialStateEditing: false, inputTextFieldType: DCInputTextFieldType.account)
    
    let stackView                       = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutUI()
        add(childVC: dcAccountController, to: accountFieldContainerVIew)
        add(childVC: dcBranchController, to: branchFieldContainerVIew)
        add(childVC: dcValueController, to: valueFieldContainerVIew)
    }
    
    
    func configureStackView() {
        stackView.axis          = .vertical
        stackView.distribution  = .equalCentering
        stackView.addArrangedSubview(branchFieldContainerVIew)
        stackView.addArrangedSubview(accountFieldContainerVIew)
    }
    
    
    func layoutUI() {
        view.addSubview(branchFieldContainerVIew)
        view.addSubview(accountFieldContainerVIew)
        view.addSubview(valueFieldContainerVIew)
        branchFieldContainerVIew.translatesAutoresizingMaskIntoConstraints  = false
        accountFieldContainerVIew.translatesAutoresizingMaskIntoConstraints = false
        valueFieldContainerVIew.translatesAutoresizingMaskIntoConstraints   = false
        
        
        let padding: CGFloat    = 20
        
        NSLayoutConstraint.activate([
            branchFieldContainerVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            branchFieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            branchFieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            branchFieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            accountFieldContainerVIew.topAnchor.constraint(equalTo: branchFieldContainerVIew.bottomAnchor, constant: 0),
            accountFieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            accountFieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            accountFieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])

        NSLayoutConstraint.activate([
            valueFieldContainerVIew.topAnchor.constraint(equalTo: accountFieldContainerVIew.bottomAnchor, constant: 0),
            valueFieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            valueFieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            valueFieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

