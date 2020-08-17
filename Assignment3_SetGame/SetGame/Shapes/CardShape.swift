//
//  CardShape.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/17/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct CardShape: Shape {
    
    let card: SetGame.Card
    
    func path(in rect: CGRect) -> Path {
        switch card.shape {
        case .diamond:
            return Diamond().path(in: rect)
        case .ellipse:
            return Ellipse().path(in: rect)
        case .triangle:
            return Triangle().path(in: rect)
        }
    }
    
}
