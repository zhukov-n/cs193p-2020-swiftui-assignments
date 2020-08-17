//
//  Theme.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/29/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Theme<CardContent> {
    let name: String
    let emojies: [CardContent]
    let numberToShow: Int
    let color: Color
    let cardContentFactory: (Int) -> CardContent
}

extension Theme {
    init(
        name: String,
        emojies: [CardContent],
        color: Color) {

        self.name = name
        self.emojies = emojies
        self.color = color
        self.cardContentFactory = { index in emojies[index] }
        
        numberToShow = Int.random(in: 2..<5)
        
    }
}
