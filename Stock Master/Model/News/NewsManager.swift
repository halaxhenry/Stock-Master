//
//  NewsManager.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/31.
//

import Foundation

protocol NewsManagerDelegate {
    func didUpdateNews(news: NewsModel)
    func didFailWithNewsError(error: Error)
}

struct NewsManager {
    
    let newsAPIURLHead = "https://newsapi.org/v2/top-headlines?q="
    let newsAPIURLTail = "&from=2021-12-31&sortBy=publishedAt&apiKey=8a74e2d7e6cb4c39a48f322f555895c9"
    
    var delegate: NewsManagerDelegate?
    
    func fetchTitle(title: String){
        print(title)
        let urlString = "\(newsAPIURLHead)\(title)\(newsAPIURLTail)"
        print(urlString)
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {(data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithNewsError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let news = self.parseJSON(safeData){
                        self.delegate?.didUpdateNews(news: news)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ newsData: Data) -> NewsModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(NewsParent.self, from: newsData)
            
            let publishedAt = decodedData.articles[0].publishedAt
            let title = decodedData.articles[0].title
            let description = decodedData.articles[0].description
            let url = decodedData.articles[0].url
            let urlToImage = decodedData.articles[0].urlToImage
            
            let news = NewsModel(title: title, description: description, url: url, urlToImage: urlToImage, publishedAt: publishedAt)
            
            print("\(publishedAt) (\(title)) : \(description)")
            
            return news
            
        } catch {
            delegate?.didFailWithNewsError(error: error)
            return nil
        }
        
    }
}
