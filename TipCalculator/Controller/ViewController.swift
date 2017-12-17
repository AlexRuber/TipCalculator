//
//  ViewController.swift
//  TipCalculator
//
//  Created by Mihai Ruber on 10/31/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController, CurrencyTransferDelegate {
    
    @IBOutlet weak var totalCurrency: UILabel!
    @IBOutlet weak var tipPercentTextField: UITextField!
    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var totalTip: UILabel!
    @IBOutlet weak var total: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        tipPercentTextField.setBottomLine(borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        billTextField.setBottomLine(borderColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
        
        Alamofire.request("https://api.coinmarketcap.com/v1/ticker/?limit=10").responseJSON {response in
            if let arrayList = response.result.value as? [[String: Any]]{
                for dictionary in arrayList{
                    print(dictionary["symbol"]!)
                    print(dictionary["price_usd"]!)
                }
            }
        }
        
        
        
        //Hides Navigation Bar line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    func userDidChoose(currencyType: String, price: String) {
        totalCurrency.text = "Total " + currencyType
        //Setting Nav Bar title to specific currency
        self.navigationItem.title = currencyType
        self.total.text = price
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "presentCurrencyVC" {
            guard let currencyPickerVC = segue.destination as? SettingsViewController else { return }
            currencyPickerVC.delegate = self
        }
    }
    
}

