//
//  CardView.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/17/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct CardView: View {
    var card: SetGame.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size, spacing: 10)
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize, spacing: CGFloat) -> some View {
        HStack(alignment: .center) {
            VStack(spacing: spacing) {
                ForEach(0..<card.count) { _ in
                    Group {
                        if self.card.shading == .stroke {
                            CardShape(card: self.card)
                                .stroke(lineWidth: 3)
                        } else {
                            CardShape(card: self.card)
                                
                        }
                    }
                    .frame(height: self.height(size: size, count: 3, spacing: spacing))
                }
            }
        }
        .padding(.all, spacing)
        .foregroundColor(color(card: card).opacity(card.shading == .transparent ? 0.4 : 1))
        .cardify()
        .foregroundColor(card.isSelected ? .orange : .black)
        
    }
    
    private func height(size: CGSize, count: Int, spacing: CGFloat) -> CGFloat {
        (size.height - CGFloat(count + 1) * spacing) / CGFloat(count)
    }

    func color(card: SetGame.Card) -> Color {
        switch card.color {
        case .blue:
            return Color.blue
        case .green:
            return Color.green
        case .red:
            return Color.red
        }
    }
    
}
