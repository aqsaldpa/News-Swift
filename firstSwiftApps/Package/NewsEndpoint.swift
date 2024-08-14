//
//  Endpoint.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import Foundation

protocol APIBuilder {
    var urlRequest: URLRequest { get }
    var baseUrl: URL {get}
    var path: String {get}
}

enum NewsAPI {
    case getNews
}

extension NewsAPI: APIBuilder {
    var baseUrl: URL{
        switch self {
        case .getNews:
            return URL(string: Constant.baseURL + "everything")!
        }
    }
    
    var path: String{
        return "/news"
    }
    
    var urlRequest: URLRequest{
        var urlComponents = URLComponents(url: self.baseUrl, resolvingAgainstBaseURL: false)!
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: "apple"),
            URLQueryItem(name: "from", value: "2024-08-13"),
            URLQueryItem(name: "to", value: "2024-08-13"),
            URLQueryItem(name: "sortBy", value: "popularity"),
            URLQueryItem(name: "apiKey", value: Constant.apiKey)
        ]
        return URLRequest(url: urlComponents.url!)
    }
}
