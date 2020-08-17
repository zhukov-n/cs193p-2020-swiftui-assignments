//
//  EmojiMemoryGame.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/28/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

class EmojiMemoryGame: ObservableObject {
    
    let themeStorage = ThemeStorage()

    @Published private var model: MemoryGame<String>
    
    init(model: MemoryGame<String>) {
        self.model = model
    }
    
    // MARK: - Access to the Model

    var cards: [MemoryGame<String>.Card] { model.cards }
    
    // MARK: - Intent
    
    func choose(card: MemoryGame<String>.Card) {
        model.choose(card)
    }
    
    func startNewGame() {
        model.theme = themeStorage.randomTheme
    }
    
    var theme: Theme<String> { model.theme }
    
    var score: Int { model.scrore }
}
