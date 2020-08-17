//
//  Theme.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/29/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Theme<CardContent>: Encodable where CardContent: Encodable {
    enum CodingKeys: CodingKey {
        case name, emojies, numberToShow, color
    }
    
    let name: String
    let emojies: [CardContent]
    let numberToShow: Int
    let color: UIColor
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(name, forKey: .name)
        try container.encode(emojies, forKey: .emojies)
        try container.encode(numberToShow, forKey: .numberToShow)
        try container.encode(color.rgb, forKey: .color)
    }
}


extension Theme {
    init(
        name: String,
        emojies: [CardContent],
        color: UIColor,
        numberToShow: Int) {

        self.name = name
        self.emojies = emojies
        self.color = color
        self.numberToShow = numberToShow
    }

    var cardContentFactory: (Int) -> CardContent { { ind in
            self.emojies[ind]
        }
    }
    
    var json: String {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return String(decoding: data, as: UTF8.self)
    }
}
