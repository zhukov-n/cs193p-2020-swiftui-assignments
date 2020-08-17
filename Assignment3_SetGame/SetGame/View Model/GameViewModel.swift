//
//  GameViewModel.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/14/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Foundation

class GameViewModel: ObservableObject {
    
    // MARK: - Access to the Model
    
    @Published private var model = SetGame()
    
    var cards: [SetGame.Card] { model.cards }
    var shownCards: [SetGame.Card] { model.shownCards }
    
    // MARK: - Intent
    
    func choose(card: SetGame.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model.createGame()
    }
    
    func deal3More() {
        model.deal3More()
    }

}
