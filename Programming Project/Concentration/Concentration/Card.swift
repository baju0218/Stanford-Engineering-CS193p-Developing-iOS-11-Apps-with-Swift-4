//
//  Card.swift
//  Concentration
//
//  Created by 백종운 on 2021/02/16.
//

import Foundation

struct Card {
    var isShow = false
    var isFaceUp = false
    var isMatched = false
    private var identifier: Int
    
    private static var identiferFactory = 0
    
    private static func getUniqueIdentifier() -> Int {
        identiferFactory += 1
        return identiferFactory
    }
    
    init() {
        self.identifier = Card.getUniqueIdentifier()
    }
}

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.identifier == rhs.identifier
    }
}
