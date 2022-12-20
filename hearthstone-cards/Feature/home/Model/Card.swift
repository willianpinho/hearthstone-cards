//
//  Card.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation

struct Card: Codable {
    var cardID: String?
    var dbfID: Int?
    var name: String?
    var cardSet: String?
    var type: String?
    var text, playerClass: String?
    var locale: String?
    var faction: String?
    var mechanics: [Mechanic]?
    var rarity: String?
    var cost: Int?
    var flavor, artist, spellSchool: String?
    var attack, health: Int?
    var race: String?
    var img: String?
    var durability: Int?

    enum CodingKeys: String, CodingKey {
        case cardID = "cardId"
        case dbfID = "dbfId"
        case name, cardSet, type, text, playerClass, locale, faction, mechanics, rarity, cost, flavor, artist, spellSchool, attack, health, race, img, durability
    }
}
