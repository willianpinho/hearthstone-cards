//
//  Injected.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Swinject

@propertyWrapper
public struct Injected<T> {

    var dependency: T!
    
    public init() {}

    public var wrappedValue: T {
        mutating get {
            if dependency == nil {
                guard let copy: T = ApplicationContainer.shared.get() else {
                    fatalError("Could not resolve dependency for \(T.self)")
                }
                self.dependency = copy
            }
            return dependency
        }
        mutating set {
            dependency = newValue
        }
    }
}
