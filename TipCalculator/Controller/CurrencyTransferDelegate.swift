//
//  CurrencyTransferDelegate.swift
//  TipCalculator
//
//  Created by Mihai Ruber on 12/16/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import Foundation
import UIKit

protocol CurrencyTransferDelegate {
    func userDidChoose(currencyType: String, price: String, symbol: String)
    
    
}
