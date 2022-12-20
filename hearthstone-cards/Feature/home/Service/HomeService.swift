//
//  HomeService.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Alamofire
import Combine

protocol HomeServiceProtocol {
    func getCardBasic() -> AnyPublisher<Result<[Card], Error>, Never>
}

class HomeService: HomeServiceProtocol {
    private var provider: BaseAlamofireProvider?
    
    init(provider: BaseAlamofireProvider?) {
        self.provider = provider
    }
    
    func getCardBasic() -> AnyPublisher<Result<[Card], Error> , Never> {
        guard let provider = provider else {
            return Just(.failure(InternalError())).eraseToAnyPublisher()
        }
        
        let urlEndPoint = "https://omgvamp-hearthstone-v1.p.rapidapi.com/cards/sets/Basic"
        
        let headers: HTTPHeaders = .init(["X-RapidAPI-Key": "0f82444620msh504d57a0ebe7b97p1c54d7jsna01f4c9f7380",
                                          "X-RapidAPI-Host": "omgvamp-hearthstone-v1.p.rapidapi.com"])


        return provider.request(urlEndPoint, headers: headers)
            .validate()
            .publishDecodable(type: [Card].self)
            .result()
            .map { result -> Result<[Card], Error> in
                switch result {
                case .success(let value):
                    return .success(value)
                case .failure(let error):
                    return .failure(error)
                }
            }
            .eraseToAnyPublisher()
    }
}

public class InternalError: Error {
    public init() {}
}

public class UnauthenticatedError: Error {
    public init() {}
}
