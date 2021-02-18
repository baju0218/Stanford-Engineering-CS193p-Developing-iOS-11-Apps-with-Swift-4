//
//  Concentration.swift
//  Concentration
//
//  Created by 백종운 on 2021/02/16.
//

import Foundation

struct Concentration {
    private(set) var cards = [Card]()
    private(set) var flipCount = 0
    private(set) var score = 0
    
    private var indexOfOneAndOnlyFaceUpCard: Int? {
        get {
            return cards.indices.filter{ cards[$0].isFaceUp }.oneAndOnly
        }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func chooseCard(at index: Int) {
        assert(cards.indices.contains(index), "Concentration.chooseCard(at: \(index)): chosen index not in the cards")
        
        if !cards[index].isMatched {
            if let matchIndex = indexOfOneAndOnlyFaceUpCard, matchIndex != index {
                if cards[matchIndex] == cards[index] {
                    cards[matchIndex].isMatched = true
                    cards[index].isMatched = true
                    score += 2
                }
                else {
                    if cards.indices.filter( { $0 != matchIndex && cards[$0] == cards[matchIndex] && cards[$0].isShow } ).count == 1 { score -= 1 }
                    else if cards[index].isShow { score -= 1 }
                    else if cards[matchIndex].isShow { score -= 1 }
                    
                    cards[matchIndex].isShow = true
                    cards[index].isShow = true
                }
                cards[index].isFaceUp = true
                flipCount += 1
            }
            else if indexOfOneAndOnlyFaceUpCard == nil {
                indexOfOneAndOnlyFaceUpCard = index
                flipCount += 1
            }
        }
    }
    
    init(numberOfPairsOfCards: Int) {
        assert(numberOfPairsOfCards > 0, "Concentration.init(\(numberOfPairsOfCards)): you must have at least one pair of cards")
        
        for _ in 1...numberOfPairsOfCards {
            let card = Card()
            cards += [card, card]
        }
        
        cards.shuffle()
    }
}

extension Collection {
    var oneAndOnly: Element? {
        return count == 1 ? first : nil
    }
}
