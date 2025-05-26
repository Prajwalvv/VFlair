//
//  LeftPaddedTextField.swift
//  vFlair
//
//  Created by Prajwal V.v on 02/11/18.
//  Copyright © 2018 fluid. All rights reserved.
//

import UIKit
class leftPaddedTextField: UITextField {
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
    
}
