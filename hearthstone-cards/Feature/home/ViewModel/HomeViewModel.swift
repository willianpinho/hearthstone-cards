//
//  HomeViewModel.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Combine

enum HomeViewModelProtocolInput {
    case fetchCards
}

enum HomeViewModelProtocolOutput {
    case success
    case error
}

protocol HomeViewModelProtocol {
    func transform(input: AnyPublisher<HomeViewModelProtocolInput, Never>) -> AnyPublisher<HomeViewModelProtocolOutput, Never>
    var cards: [Card] { get }
}

class HomeViewModel: HomeViewModelProtocol {
    
    private let homeUseCase: HomeUseCaseProtocol?
    private var subscriptions = Set<AnyCancellable>()
    public var cards : [Card] = []
    private let output: PassthroughSubject<HomeViewModelProtocolOutput, Never> = .init()
    
    init(homeUseCase: HomeUseCaseProtocol?) {
        self.homeUseCase = homeUseCase
    }
    
    func transform(input: AnyPublisher<HomeViewModelProtocolInput, Never>) -> AnyPublisher<HomeViewModelProtocolOutput, Never> {
        input.sink { [weak self] event in
            switch event {
            case .fetchCards:
                self?.requestCards()
            }
        }.store(in: &subscriptions)
        
        return output.eraseToAnyPublisher()
    }
    
    private func requestCards() {
        homeUseCase?.execute().sink { [weak self] value in
            switch value {
            case .success(let cards):
                self?.cards = cards
                self?.output.send(.success)
            case .failure(_):
                self?.output.send(.error)
            }
        }.store(in: &subscriptions)
    }
}
