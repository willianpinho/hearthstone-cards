//
//  CardViewModel.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Combine

enum CardViewModelProtocolInput {
    case fetchCard(String)
}

enum CardViewModelProtocolOutput {
    case success
    case error
}

protocol CardViewModelProtocol {
    func transform(input: AnyPublisher<CardViewModelProtocolInput, Never>) -> AnyPublisher<CardViewModelProtocolOutput, Never>
    var card: Card? { get set }
}

class CardViewModel: CardViewModelProtocol {
    
    private let cardUseCase: CardUseCaseProtocol?
    private var subscriptions = Set<AnyCancellable>()
    public var card : Card?
    private let output: PassthroughSubject<CardViewModelProtocolOutput, Never> = .init()
    public var cards : [Card] = []
    
    init(cardUseCase: CardUseCaseProtocol?) {
        self.cardUseCase = cardUseCase
    }
    
    func transform(input: AnyPublisher<CardViewModelProtocolInput, Never>) -> AnyPublisher<CardViewModelProtocolOutput, Never> {
        input.sink { [weak self] event in
            switch event {
            case .fetchCard(let cardID):
                self?.requestCard(cardId: cardID)
            }
        }.store(in: &subscriptions)
        
        return output.eraseToAnyPublisher()
    }
    
    private func requestCard(cardId: String) {
        cardUseCase?.execute(cardId: cardId).sink { [weak self] value in
            switch value {
            case .success(let cards):
                self?.card = cards.first ?? Card()
                self?.output.send(.success)
            case .failure(_):
                self?.output.send(.error)
            }
        }.store(in: &subscriptions)
    }
}
