//
//  Cardify.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 7/13/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Cardify: AnimatableModifier {
    
    private enum DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    var rotation: Double
    var isFaceUp: Bool { rotation < 90 }

    var animatableData: Double {
        get { rotation }
        set { rotation = newValue }
    }
    
    init(isFaceUp: Bool) {
        rotation = isFaceUp ? 0 : 180
    }
    
    func body(content: Content) -> some View {
        ZStack {
            Group {
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).stroke(lineWidth: DrawingConstants.lineWidth)
                content
            }
            .opacity(isFaceUp ? 1 : 0)
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius)
                .opacity(isFaceUp ? 0 : 1)
        }
        .rotation3DEffect(Angle(degrees: rotation), axis: (0, 1, 0))
    }
    
}

extension View {
    func cardify(isFaceUp: Bool) -> some View {
        self.modifier(Cardify(isFaceUp: isFaceUp))
    }
}
