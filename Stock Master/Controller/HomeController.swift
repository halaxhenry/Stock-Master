//
//  ViewController.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/28.
//

import UIKit

class HomeController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchedCompanyName: UILabel!
    @IBOutlet weak var searchedStockPrice: UILabel!
    @IBOutlet weak var changeInPrice: UILabel!
    
    var stockManager = StockManager() // initializer
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchBar.delegate = self
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
//        print(searchBar.text!)
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Type something"
            return false
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
        if let symbol = searchBar.text {
            stockManager.fetchSymbol(symbol: symbol)
        }
 
    }
}

