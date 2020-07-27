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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutUI()
        add(childVC: dcAccountController, to: accountFieldContainerVIew)
        add(childVC: dcBranchController, to: branchFieldContainerVIew)
    }

    
    func layoutUI() {
        view.addSubview(branchFieldContainerVIew)
        view.addSubview(accountFieldContainerVIew)
        branchFieldContainerVIew.translatesAutoresizingMaskIntoConstraints = false
        accountFieldContainerVIew.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 30
        
        NSLayoutConstraint.activate([
            branchFieldContainerVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            branchFieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            branchFieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            branchFieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        NSLayoutConstraint.activate([
            accountFieldContainerVIew.topAnchor.constraint(equalTo: branchFieldContainerVIew.bottomAnchor, constant: 30),
            accountFieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            accountFieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            accountFieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])
        
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

