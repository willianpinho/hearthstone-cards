//
//  MainModule.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Swinject

public final class MainModule {
    
    public static func register() {
        let container = ApplicationContainer.shared.container
        container.register(NetworkCheckerManagerProtocol.self) { r in
            return NetworkCheckerManager()
        }
        
        container.register(NetworkCheckerInterceptor.self) { r in
            return NetworkCheckerInterceptor(networkCheckerManager: r.get())
        }.inObjectScope(.container)
        
        container.register(BaseAlamofireProvider.self) { r in
            return BaseAlamofireProvider(networkInterceptor: r.get())
        }
        
        container.register(HomeViewModelProtocol.self) { r in
            return HomeViewModel(homeUseCase: r.get())
        }
        
        container.register(HomeUseCaseProtocol.self) { r in
            return HomeUseCase(service: r.get())
        }
        
        container.register(HomeServiceProtocol.self) { r in
            return HomeService(provider: r.get())
        }
        
        container.register(CardServiceProtocol.self) { r in
            return CardService(provider: r.get())
        }
        
        container.register(CardUseCaseProtocol.self) { r in
            return CardUseCase(service: r.get())
        }
        
        container.register(CardViewModelProtocol.self) { r in
            return CardViewModel(cardUseCase: r.get())
        }
        
        
    }
}

extension Bundle {
    static var module: Bundle = {
        return Bundle.main
    }()
}
