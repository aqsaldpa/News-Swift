//
//  NewsResponse.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import Foundation

struct NewsResponse: Codable {
    let articles: [Article]
}

struct Source: Codable {
    let id: String?
    let name: String?
}

struct Article: Codable, Identifiable {
    var id = UUID()
    let source: Source
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    let publishedAt: String?
    
    private enum CodingKeys: String, CodingKey {
        case source, author, title, description, url, urlToImage, publishedAt
    }
}


extension Article {
    static var dummyData: Article {
        return Article(
            source: Source(id: "the-verge", name: "The Verge"),
            author: "Umar Shakir",
            title: "Rivian is bringing Apple Music with spatial audio to its CarPlay-less EVs",
            description: "Rivian is pushing a new software update that includes Apple Music, but it requires a Connect Plus subscription to work on the go, while CarPlay is still not an option.",
            url: "https://www.theverge.com/2024/8/13/24218973/rivian-apple-music-connect-plus-subscribe-fee",
            urlToImage: "https://cdn.vox-cdn.com/thumbor/VP6uyOjssejvOtwgeMQY6jtkeAQ=/0x0:2048x1365/1200x628/filters:focal(1024x683:1025x684)/cdn.vox-cdn.com/uploads/chorus_asset/file/24585492/236609_Rivian_R1S_review_DGolson_0013.jpg",
            publishedAt: "2024-08-13T13:00:00Z"
        )
    }
}
