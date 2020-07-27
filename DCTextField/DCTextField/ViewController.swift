//
//  ViewController.swift
//  DCTextField
//
//  Created by Daniel on 26/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let fieldContainerVIew      = UIView()
    let dcSimpleController      = DCSimpleFieldVC(title: "Nome", placeHolder: "Digite...", isInitialStateEditing: false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        layoutUI()
        add(childVC: dcSimpleController, to: fieldContainerVIew)
    }

    
    func layoutUI() {
        view.addSubview(fieldContainerVIew)
        fieldContainerVIew.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = 50
        
        NSLayoutConstraint.activate([
            fieldContainerVIew.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            fieldContainerVIew.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            fieldContainerVIew.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            fieldContainerVIew.heightAnchor.constraint(equalToConstant: 150)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func toogleSimpleTFOpenClose() {
        dcSimpleController.toogleFieldEditingAnimation()
    }
}

