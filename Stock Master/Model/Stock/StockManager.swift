//
//  StockManager.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/29.
//

import Foundation

protocol StockManagerDelegate {
    func didUpdateStock(stock: StockModel)
    func didFailWithStockError(error: Error)
}

struct StockManager {
    
    let yahooFinanceURL = "https://yfapi.net/v6/finance/quote?region=US&lang=en&symbols="
    
    var delegate: StockManagerDelegate?
    
    func fetchSymbol(symbol: String){
        let urlString = "\(yahooFinanceURL)\(symbol)%2CBTC-USD%2CEURUSD%3DX"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue("veVSnxbrXJ9dwZMDSyQVW3f268JIe7V3Ty4fxqOj", forHTTPHeaderField: "x-api-key")
            request.httpMethod = "GET"
            let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithStockError(error: error!)
                    return
                }
                if let safeData = data {
                    if let stock = self.parseJSON(safeData) {
                        self.delegate?.didUpdateStock(stock: stock)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func parseJSON(_ stockData: Data) -> StockModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(QuoteParent.self, from: stockData)
            
            let bid = decodedData.quoteResponse.result![0].bid!
            let company = decodedData.quoteResponse.result![0].longName!
            let symbol = decodedData.quoteResponse.result![0].symbol!
            
            let stock = StockModel(company: company, symbol: symbol, bid: bid)
            
//            print("\(company) (\(symbol)) : \(bid)")
            
            return stock
            
        } catch {
            delegate?.didFailWithStockError(error: error)
            return nil
        }
        
    }
    
}



