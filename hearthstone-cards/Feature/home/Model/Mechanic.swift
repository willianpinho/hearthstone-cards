//
//  Mechanic.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation

struct Mechanic: Codable {
    var name: String?
    
    enum CodingKeys: String, CodingKey {
        case name
    }
}
