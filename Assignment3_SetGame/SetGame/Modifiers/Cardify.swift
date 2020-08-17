//
//  Cardify.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/16/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Cardify: ViewModifier {
    
    private enum DrawingConstants {
        static let cornerRadius: CGFloat = 10
        static let lineWidth: CGFloat = 3
    }
    
    func body(content: Content) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).fill(Color.white)
            RoundedRectangle(cornerRadius: DrawingConstants.cornerRadius).stroke(lineWidth: DrawingConstants.lineWidth)
            content
        }
        
        .aspectRatio(2/3, contentMode: .fit)
    }
}

extension View {
    func cardify() -> some View {
        modifier(Cardify())
    }
}
