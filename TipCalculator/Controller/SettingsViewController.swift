//
//  SettingsViewController.swift
//  TipCalculator
//
//  Created by Mihai Ruber on 11/1/17.
//  Copyright © 2017 Mihai Ruber. All rights reserved.
//

import UIKit
import Foundation
import Alamofire


class SettingsViewController: UIViewController {

    var delegate: CurrencyTransferDelegate? = nil
    
    @IBOutlet weak var bitcoinRate: UILabel!
    @IBOutlet weak var etherRate: UILabel!
    @IBOutlet weak var litecoinRate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        Alamofire.request("https://api.coinmarketcap.com/v1/ticker/?limit=10").responseJSON {response in
            if let arrayList = response.result.value as? [[String: Any]]{
                for dictionary in arrayList{
                    if (String(describing: dictionary["symbol"]!)) == "BTC"{
                        self.bitcoinRate.text = "$" + String(describing: dictionary["price_usd"]!)
                    }
                    if (String(describing: dictionary["symbol"]!)) == "ETH"{
                        self.etherRate.text = "$" + String(describing: dictionary["price_usd"]!)
                    }
                    if (String(describing: dictionary["symbol"]!)) == "LTC"{
                        self.litecoinRate.text = "$" + String(describing: dictionary["price_usd"]!)
                    }
                }
            }
        }
        
        //Hides Navigation Bar line
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("view did appear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("view will disappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("view did disappear")
    }
    
    
    @IBAction func currencyTypeWasPressed(sender: UIButton) {
        if sender.titleLabel?.text == "Bitcoin" {
            delegate?.userDidChoose(currencyType: (sender.titleLabel!.text!), price: bitcoinRate.text! )

        }
        if sender.titleLabel?.text == "Ether" {
            delegate?.userDidChoose(currencyType: (sender.titleLabel!.text!), price: etherRate.text! )
            
        }
        if sender.titleLabel?.text == "Litecoin" {
            delegate?.userDidChoose(currencyType: (sender.titleLabel!.text!), price: litecoinRate.text! )
            
        }
        self.navigationController?.popViewController(animated: true)
    }



}
