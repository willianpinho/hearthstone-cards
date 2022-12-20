//
//  Scope.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Swinject

public enum Scope {
    case transient
    case graph
    case container
    case weak
    
    var objectScope: ObjectScope {
        get {
            switch self {
            case .transient:
                return .transient
            case .graph:
                return .graph
            case .container:
                return .container
            case .weak:
                return .weak
            }
        }
    }
}
