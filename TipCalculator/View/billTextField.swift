//
//  billTextField.swift
//  TipCalculator
//
//  Created by Mihai Ruber on 12/17/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import UIKit

class billTextField: UITextField {



}

extension UITextField {
    
    func setBottomLine(borderColor: UIColor) {
        
        self.borderStyle = UITextBorderStyle.none
        self.backgroundColor = UIColor.clear
        
        let borderLine = UIView()
        let height = 0.5
        borderLine.frame = CGRect(x: 0, y: Double(self.frame.height) - height, width: Double(self.frame.width), height: height)
        
        borderLine.backgroundColor = borderColor
        self.addSubview(borderLine)
    }
    
}
