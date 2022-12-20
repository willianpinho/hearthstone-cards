//
//  ApplicationContainer.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Swinject

public class ApplicationContainer {
    public static let shared: ApplicationContainer = { return ApplicationContainer() }()
    
    public var container: Container
    
    init() {
        container = Container()
    }
    
    public func get<T>() -> T? {
        return container.resolve(T.self)
    }
    
    public func register<Service>(
        _ serviceType: Service.Type,
        name: String? = nil,
        scope: Scope = .graph,
        factory: @escaping (ApplicationContainer) -> Service
    ) {
        container.register(serviceType, name: name) {_ in
            return {
                factory(self)
            }()
        }.inObjectScope(scope.objectScope)
    }
}
