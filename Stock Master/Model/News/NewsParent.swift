//
//  NewsModel.swift
//  Stock Master
//
//  Created by Seungchul Ha on 2022/01/31.
//

import Foundation

struct NewsParent: Codable {
    var articles: [Article]
}

struct Article: Codable {
    let title: String
    let url: String
    let urlToImage: String
    let description: String
    let publishedAt: String
 
//    enum CodingKeys: String, CodingKey {
//        case id, title, url
//        case urlToImage = "imageUrl"
//        case description, publishedAt
//    }
    
    init() {
        title = ""
        url = ""
        urlToImage = ""
        description = ""
        publishedAt = ""
    }
}

