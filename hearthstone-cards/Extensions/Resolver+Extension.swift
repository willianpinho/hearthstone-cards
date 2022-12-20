//
//  Resolver+Extension.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Swinject

public extension Resolver {
    func get<T>() -> T? {
        return self.resolve(T.self)
    }
}
