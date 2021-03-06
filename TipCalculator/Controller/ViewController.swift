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
    @IBOutlet weak var tipLabel: UILabel!
    public var currPrice: Double! = 0.0
    public var currSymb: String! = "USD"
    
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
    
    
    func userDidChoose(currencyType: String, price: String, symbol: String) {

        //USD Case
        if price == "USD"{
            self.navigationItem.title = "USD"
            currSymb = symbol
            self.total.text = "0.00" + symbol
            self.totalTip.text = "0.00" + symbol
            
        } else {
            //Setting Nav Bar title to specific currency
            self.navigationItem.title = currencyType + " @ $\(price)"
            
            self.total.text = "0.00" + symbol
            self.totalTip.text = "0.00" + symbol
            self.tipLabel.text = "TIP"
            self.totalCurrency.text = "TOTAL"
            
            currPrice = Double(price)!
            currSymb = symbol
        }

        
    }
    
    //Tip Logic
    @IBAction func calculateTipBill(_ sender: Any) {
        let USbill = Double(billTextField.text!) ?? 0
        let USpercent = Double(tipPercentTextField.text!) ?? 0
        let USTipAmount = Double(USbill * (USpercent/100))
        let USTotal = Double(USbill + USTipAmount)
       
        if navigationItem.title == "USD" {
            
            total.text = "\(USTotal) \(currSymb!)"
            totalTip.text = "\(USTipAmount) \(currSymb!)"
        } else {
            
            let CryptoTipAmount = Double(round(1000*(USTipAmount / currPrice))/1000)
            let CryptoTotalAmount = Double(round(1000*(USTotal / currPrice))/1000)
            
            total.text = "\(CryptoTotalAmount) \(currSymb!)"
            totalTip.text = "\(CryptoTipAmount) \(currSymb!)"
        }

    }
    
    @IBAction func calculateTipPercent(_ sender: Any) {
        let USbill = Double(billTextField.text!) ?? 0
        let USpercent = Double(tipPercentTextField.text!) ?? 0
        let USTipAmount = Double(USbill * (USpercent/100))
        let USTotal = Double(USbill + USTipAmount)
        
        if navigationItem.title == "USD" {
            total.text = "\(USTotal) \(currSymb!)"
            totalTip.text = "\(USTipAmount) \(currSymb!)"
        } else {
            
            let CryptoTipAmount = Double(round(1000*(USTipAmount / currPrice))/1000)
            let CryptoTotalAmount = Double(round(1000*(USTotal / currPrice))/1000)
            
            total.text = "\(CryptoTotalAmount) \(currSymb!)"
            totalTip.text = "\(CryptoTipAmount) \(currSymb!)"
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Initialize to zero
        tipPercentTextField.text = ""
        billTextField.text = ""
        
        if segue.identifier == "presentCurrencyVC" {
            guard let currencyPickerVC = segue.destination as? SettingsViewController else { return }
            currencyPickerVC.delegate = self
        }
    }
    
}

