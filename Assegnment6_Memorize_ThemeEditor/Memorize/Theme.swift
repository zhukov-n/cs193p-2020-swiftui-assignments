//
//  Theme.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/29/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Theme<CardContent>: Codable, Identifiable where CardContent: Codable {
    
    let id: UUID
    
    enum CodingKeys: CodingKey {
        case id, name, emojies, numberToShow, color
    }
    
    var name: String
    var emojies: [CardContent]
    var numberToShow: Int
    let color: UIColor

    init(
        id: UUID? = nil,
        name: String = "Untitled",
        emojies: [CardContent] = [],
        color: UIColor = .blue,
        numberToShow: Int = 3) {

        self.id = id ?? UUID()
        self.name = name
        self.emojies = emojies
        self.color = color
        self.numberToShow = numberToShow
    }
    
    init?(json: Data?) {
        guard
            let json = json,
            let theme = try? JSONDecoder().decode(Theme.self, from: json)
        else { return nil }
        
        self = theme
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try container.decode(UUID.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        emojies = try container.decode([CardContent].self, forKey: .emojies)
        numberToShow = try container.decode(Int.self, forKey: .numberToShow)
        let rgbColor = try container.decode(UIColor.RGB.self, forKey: .color)
        color = .init(rgbColor)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(emojies, forKey: .emojies)
        try container.encode(numberToShow, forKey: .numberToShow)
        try container.encode(color.rgb, forKey: .color)
    }
    
}


extension Theme {
    
    var cardContentFactory: (Int) -> CardContent { { ind in
            self.emojies[ind]
        }
    }
    
    var json: String {
        let data = (try? JSONEncoder().encode(self)) ?? Data()
        return String(decoding: data, as: UTF8.self)
    }
}
