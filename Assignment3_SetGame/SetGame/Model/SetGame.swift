//
//  SetGame.swift
//  SetGame
//
//  Created by Nikolay Zhukov on 7/13/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

struct SetGame {

    enum Constants {
        static let numberOfElements = 3
        static let startCardCount = 12
    }
    
    var shownCards: [Card] { Array(cards.filter { !$0.isMatch }[0..<min(cards.count, shownCount)]) }
    var selectedCards: [Card] { cards.filter { $0.isSelected } }
    
    private(set) var cards: [Card] = []
    private(set) var shownCount = Constants.startCardCount

    mutating func createGame() {
        cards.removeAll()
        shownCount = Constants.startCardCount
        
        var id = 0
        for i in 1...3 {
            for j in 0..<Card.ShapeType.allCases.count {
                for k in 0..<Card.Shading.allCases.count {
                    for l in 0..<Card.ForegroundColor.allCases.count {
                        let shape = Card.ShapeType.allCases[j]
                        let shading = Card.Shading.allCases[k]
                        let color = Card.ForegroundColor.allCases[l]
                        cards.append(Card(id: id, shape: shape, shading: shading, count: i, color: color))
                        id += 1
                    }
                }
            }
        }
        
        cards.shuffle()
    }
    
    mutating func deal3More() {
        shownCount += 3
    }
    
    mutating func choose(_ card: Card) {
        guard let index = cards.firstIndex(where: { $0.id == card.id }) else { return }

        if selectedCards.count < 3 || cards[index].isSelected {
            cards[index].isSelected.toggle()
        }
        
        if selectedCards.count == 3 {
            checkMatch()
        }
    }
    
    private mutating func checkMatch() {
        let countSet = Set(selectedCards.map { $0.count })
        let colorSet = Set(selectedCards.map { $0.color })
        let shapeSet = Set(selectedCards.map { $0.shape })
        let shadingSet = Set(selectedCards.map { $0.shading })
        
        let isSet = countSet.count != 2
            && colorSet.count != 2
            && shapeSet.count != 2
            && shadingSet.count != 2
        
        if isSet {
            for card in selectedCards {
                if let index = cards.firstIndex(matching: card) {
                    cards[index].isMatch = true
                    cards[index].isSelected = true
                }
            }
        }
    }
    
    struct Card: Identifiable {
        
        enum Shading: CaseIterable {
            case transparent
            case solid
            case stroke
        }
        
        enum ForegroundColor: CaseIterable {
            case red
            case green
            case blue
        }
        
        enum ShapeType: CaseIterable {
            case diamond
            case triangle
            case ellipse
        }
        
        var id: Int
        var isMatch: Bool = false
        var isSelected: Bool = false
        let shape: ShapeType
        let shading: Shading
        let count: Int
        let color: ForegroundColor
    }
}


