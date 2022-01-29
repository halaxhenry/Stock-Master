//
//  StockManager.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/29.
//

import Foundation

struct StockManager {
    
    let yahooFinanceURL = "https://yfapi.net/v6/finance/quote?region=US&lang=en&symbols="

    func fetchSymbol(symbol: String){
        let urlString = "\(yahooFinanceURL)\(symbol)%2CBTC-USD%2CEURUSD%3DX"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {

        if let url = URL(string: urlString) {
            
            var request = URLRequest(url: url)
            
            request.addValue("veVSnxbrXJ9dwZMDSyQVW3f268JIe7V3Ty4fxqOj", forHTTPHeaderField: "x-api-key")
            
            request.httpMethod = "GET"
            
            let dataTask = URLSession.shared.dataTask(with: request, completionHandler: handle(data: response: error:))
            
            dataTask.resume()

        }
        
        func handle(data: Data?, response: URLResponse?, error: Error?) {
            if error != nil {
                print(error!)
                return
            }
            
            if let safeData = data {
//                let dataString = String(data: safeData, encoding: .utf8)
//                print(dataString!)
                print(safeData)
                parseJSON(stockData: safeData)
                
            }
        }
        
        func parseJSON(stockData: Data) {
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(QuoteParent.self, from: stockData)
                
                let bid = decodedData.quoteResponse.result![0].bid!
                let company = decodedData.quoteResponse.result![0].longName!
                let symbol = decodedData.quoteResponse.result![0].symbol!
                
                print("\(company) (\(symbol)) : \(bid)")
            } catch {
                print(error)
            }
            
        }
        
    }
}
    

