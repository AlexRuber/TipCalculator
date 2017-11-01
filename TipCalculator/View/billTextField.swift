//
//  billTextField.swift
//  TipCalculator
//
//  Created by Mihai Ruber on 11/1/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import UIKit

class billTextField: UITextField {

    //Adding subview drawing
    override func draw(_ rect: CGRect) {
        let size: CGFloat = 20
        let currencyLbl = UILabel(frame: CGRect(x: 5, y: (frame.size.height / 2) - (size/2), width: size, height: size))
        currencyLbl.backgroundColor = #colorLiteral(red: 0.6185473525, green: 0.6185473525, blue: 0.6185473525, alpha: 0.8137341833)
        currencyLbl.textAlignment = .center
        currencyLbl.textColor = UIColor.white
        currencyLbl.layer.cornerRadius = 5.0
        currencyLbl.clipsToBounds = true
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = .current
        currencyLbl.text = formatter.currencySymbol
        addSubview(currencyLbl)
    }
    
    override func prepareForInterfaceBuilder() {
        customView()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        customView()
    }
    
    
    func customView(){
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.25)
        layer.cornerRadius = 5.0
        textAlignment = .center
        clipsToBounds = true
        
        if let p = placeholder {
            let place = NSAttributedString(string: p, attributes: [.foregroundColor: UIColor.white])
            attributedPlaceholder = place
            textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }
        
    }
    
}
