//
//  MemoryGame.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/28/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

struct MemoryGame<CardContent> where CardContent: Codable & Equatable {

    private(set) var cards: [Card] = []
    var scrore = 0
    
    private var indexOfTheOneAndOnlyFaceUpCard: Int? {
        get { cards.indices.filter { cards[$0].isFaceUp }.only }
        set {
            for index in cards.indices {
                cards[index].isFaceUp = index == newValue
            }
        }
    }
    
    mutating func choose(_ card: Card) {
        if let chosenIndex = self.cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            let wasSeen = self.cards[chosenIndex].wasSeen

            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    scrore += 2
                } else if wasSeen {
                    scrore -= 1
                }
                self.cards[chosenIndex].isFaceUp = true
                
            } else {
                if wasSeen {
                    scrore -= 1
                }
                
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }

            if !wasSeen && self.cards[chosenIndex].isFaceUp { self.cards[chosenIndex].wasSeen = true }
        }
    }
    
    var theme: Theme<CardContent> {
        didSet {
            createGame()
        }
    }

    init(with theme: Theme<CardContent>) {
        self.theme = theme
        createGame()
    }

    mutating func createGame() {
        scrore = 0
        cards.removeAll()
        
        let min = 2
        for pairIndex in 0..<theme.numberToShow {
            let content = theme.cardContentFactory(pairIndex)
            
            for i in 0..<min {
                cards.append(Card(id: pairIndex * theme.numberToShow + i - min, content: content))
            }
        }
        
        cards.shuffle()
    }
    
    struct Card: Identifiable {
        var id: Int
        
        var isFaceUp: Bool = false {
            didSet {
                if isFaceUp {
                    startUsingBonusTime()
                } else {
                    stopUsingBonusTime()
                }
            }
        }
        
        var isMatched: Bool = false {
            didSet {
                stopUsingBonusTime()
            }
        }
        var content: CardContent
        var wasSeen: Bool = false
        
        // MARK: - Bonus Time
        
        var bonusTimeLimit: TimeInterval = 6
        var lastFaceUpDate: Date?
        var pastFaceUpTime: TimeInterval = 0
        var bonusTimeRemaining: TimeInterval {
            max(0, bonusTimeLimit - faceUpTime)
        }
        var bonusRemaining: Double {
            (bonusTimeLimit > 0 && bonusTimeRemaining > 0) ? bonusTimeRemaining / bonusTimeLimit : 0
        }
        var hasEarnedBonus: Bool { isMatched && bonusTimeRemaining > 0 }
        var isConsumingBonusTime: Bool { isFaceUp && !isMatched && bonusTimeRemaining > 0 }
        
        private var faceUpTime: TimeInterval {
            if let lastFaceUpDate = self.lastFaceUpDate {
                return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
            } else {
                return pastFaceUpTime
            }
        }
        
        private mutating func startUsingBonusTime() {
            if isConsumingBonusTime, lastFaceUpDate == nil {
                lastFaceUpDate = Date()
            }
        }
        
        private mutating func stopUsingBonusTime() {
            pastFaceUpTime = faceUpTime
            self.lastFaceUpDate = nil
        }
    }
    
    
}
