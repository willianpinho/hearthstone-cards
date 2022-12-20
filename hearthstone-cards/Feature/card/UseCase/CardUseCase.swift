//
//  CardUseCase.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Combine

protocol CardUseCaseProtocol {
    func execute(cardId: String) -> AnyPublisher<Result<[Card], Error>, Never>
}

class CardUseCase: CardUseCaseProtocol {
    let service: CardServiceProtocol?
    
    init(service: CardServiceProtocol?) {
        self.service = service
    }
    
    func execute(cardId: String) -> AnyPublisher<Result<[Card], Error>, Never> {
        guard let service = service else { return Just(.failure(InternalError())).eraseToAnyPublisher() }
        return service.getCard(cardId: cardId)
    }
}
