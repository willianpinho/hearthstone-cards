//
//  HomeUseCase.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Combine

protocol HomeUseCaseProtocol {
    func execute() -> AnyPublisher<Result<[Card], Error>, Never>
}

class HomeUseCase: HomeUseCaseProtocol {
    let service: HomeServiceProtocol?
    
    init(service: HomeServiceProtocol?) {
        self.service = service
    }
    
    func execute() -> AnyPublisher<Result<[Card], Error>, Never> {
        guard let service = service else { return Just(.failure(InternalError())).eraseToAnyPublisher() }
        return service.getCardBasic()
    }
}
