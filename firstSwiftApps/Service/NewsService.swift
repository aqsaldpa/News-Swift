//
//  NewsService.swift
//  firstSwiftApps
//
//  Created by Aqsal Dharmaputra on 14/08/24.
//

import Foundation
import Combine

protocol NewsService {
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse,APIError>
}


struct NewsServiceImpl: NewsService{
    func request(from endpoint: NewsAPI) -> AnyPublisher<NewsResponse,APIError>{
        
        return URLSession
            .shared
            .dataTaskPublisher(for: endpoint.urlRequest)
            .receive(on: DispatchQueue.main)
            .mapError {_ in APIError.unknown}
            .flatMap { data , response -> AnyPublisher<NewsResponse,APIError> in
                guard let response = response as? HTTPURLResponse else{
                    return Fail(error: APIError.unknown).eraseToAnyPublisher()
                }
                
                if(200...299).contains(response.statusCode){
                    print("Success \(response)")
                    let jsonDecoder = JSONDecoder()
                    jsonDecoder.dateDecodingStrategy = .iso8601
                    
                    return Just(data)
                        .decode(type: NewsResponse.self, decoder: jsonDecoder)
                        .mapError { error in
                            print("Decoding error: \(error)")
                            return APIError.decodingError
                        }
                        .eraseToAnyPublisher()
                }else{
                    print(APIError.errorCode(response.statusCode))
                    return Fail(error: APIError.errorCode(response.statusCode)).eraseToAnyPublisher()
                }
            }.eraseToAnyPublisher()
    }
}
