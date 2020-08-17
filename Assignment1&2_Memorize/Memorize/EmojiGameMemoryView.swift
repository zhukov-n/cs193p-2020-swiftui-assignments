//
//  EmojiGameMemoryView.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/28/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct EmojiGameMemoryView: View {
    
    @ObservedObject var viewModel: EmojiMemoryGame
    
    var body: some View {
        VStack {
            Text("Score: \(viewModel.score)")
            
            Grid(viewModel.cards) { card in
                CardView(card: card).onTapGesture {
                    withAnimation(.linear(duration: 0.75)) {
                        self.viewModel.choose(card: card)
                    }
                    
                }
                .padding()
            }
            Button(action: {
                withAnimation(.easeInOut(duration: 0.75)) {
                    self.viewModel.startNewGame()
                }
            }, label: { Text("New Game") })
        }
        .padding()
        .foregroundColor(viewModel.theme.color)
        
    }
}

struct CardView: View {
    var card: MemoryGame<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
    }
    
    @State private var animatedBonusRemaining: Double = 0
    
    private func startBonusTimeAnimation() {
        animatedBonusRemaining = card.bonusRemaining
        withAnimation(.linear(duration: card.bonusTimeRemaining)) {
            animatedBonusRemaining = 0
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        if card.isFaceUp || !card.isMatched {
            ZStack {
                Group {
                    if card.isConsumingBonusTime {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-animatedBonusRemaining*360-90), clockwise: true)
                            .onAppear() {
                                self.startBonusTimeAnimation()
                            }
                    } else {
                        Pie(startAngle: Angle.degrees(0-90), endAngle: Angle.degrees(-card.bonusRemaining*360-90), clockwise: true)
                    }
                }
                .padding(5).opacity(0.4)
                
                
                
                Text(card.content)
                    .font(Font.system(size: fontSize(for: size)))
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                    .animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
            }
            .cardify(isFaceUp: card.isFaceUp)
            .transition(AnyTransition.scale)
            
        }
    }
    
    let fontScaleFactor: CGFloat = 0.7
    
    func fontSize(for size: CGSize) -> CGFloat {
        min(size.width, size.height) * fontScaleFactor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let faces = Theme(name: "Faces", emojies: ["😀", "😢", "😉"], color: .green)
        let model = MemoryGame<String>(with: faces)
        let game = EmojiMemoryGame(model: model)
        game.choose(card: game.cards[0])
        
        return EmojiGameMemoryView(viewModel: game)
    }
}
