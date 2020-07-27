//
//  DCSimpleTF.swift
//  DCTextField
//
//  Created by Daniel on 27/07/20.
//  Copyright © 2020 Daniel. All rights reserved.
//

import UIKit

class DCSimpleTF: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
        
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(placeHolder: String) {
        super.init(frame: .zero)
        configure()
    }
    
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        textAlignment               = .left
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 40
        
        autocorrectionType          = .no
        returnKeyType               = .done
    }

}
