//
//  ViewController.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/28.
//

import UIKit
import CoreLocation

class HomeController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchedCompanyName: UILabel!
    @IBOutlet weak var searchedStockPrice: UILabel!
    @IBOutlet weak var changeInPrice: UILabel!
    
    var stockManager = StockManager() // initializer
    var newsManager = NewsManager()
    
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        stockManager.delegate = self
        newsManager.delegate = self
        searchBar.delegate = self
        
        
        // 이 두개의 코드들은 delegate 보다 나중에 호출 되어야함으로 밑에 두어야한다 (Delegate 보다 위에 있을 경우 오류 발생)
        locationManager.requestWhenInUseAuthorization() // permission 주면 gps위치를 알수 있다 Privacy - Location When In Use Usage Description 를 info.plist 에 추가
        locationManager.requestLocation()
        
    }
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
}

// MARK: - UISearchBarDelegate


extension HomeController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
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
            newsManager.fetchTitle(title: symbol)
        }
    }
}

// MARK: - StockManagerDelegate

extension HomeController: StockManagerDelegate {
    func didUpdateStock(stock: StockModel) {
        
        DispatchQueue.main.async {
            self.searchedCompanyName.text = "\(stock.company) (\(stock.symbol))"
            self.searchedStockPrice.text =  "\(stock.bid)"
        }
        
//        print(stock.bid)
    }
    
    func didFailWithStockError(error: Error) {
        print(error)
    }
}

// MARK: - CLLocationManagerDelegate

extension HomeController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            
            print(lat)
            print(lon)
            let locale = Locale.current
            print(locale.regionCode!)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


// MARK: - NewsManagerDelegate


extension HomeController: NewsManagerDelegate {
    func didUpdateNews(news: NewsModel) {
        
//        DispatchQueue.main.async {
//            self.searchedCompanyName.text = "\(news.) (\(stock.symbol))"
//            self.searchedStockPrice.text =  "\(stock.bid)"
//        }
        
        print(news.title)
    }
    
    func didFailWithNewsError(error: Error) {
        print(error)
    }
}
