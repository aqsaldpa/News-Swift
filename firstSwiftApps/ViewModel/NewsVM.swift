//
//  NewsVM.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import Foundation
import Combine

protocol NewsVM {
    func getArticles()
}

class NewsVMImpl: ObservableObject, NewsVM {
    
    private let service: NewsService
    
    private(set) var articles = [Article]()
    private var cancellables = Set<AnyCancellable>()
    
    @Published private(set) var state: ResultState<[Article]> = .loading
    
    init(service: NewsService) {
        self.service = service
    }
    
    func getArticles() {
        
        self.state = .loading
        
        let cancellable = service
            .request(from: .getNews)
            .sink(receiveCompletion: {
                res in
                switch res {
                case .finished:
                    self.state = .success(content: self.articles)
                case .failure(let failure):
                    self.state = .failed(error: failure)
                }
            }, receiveValue: { response in
                self.articles = response.articles
            })
        cancellables.insert(cancellable)
    }
}
