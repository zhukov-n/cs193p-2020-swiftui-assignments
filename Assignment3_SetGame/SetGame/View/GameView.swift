//
//  GameView.swift
//  SetGame
//
//  Created by Nikolay Zhukov on 7/14/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

extension Animation {
    static var showing: Animation { .easeInOut(duration: 1) }
}

struct GameView: View {
    
    private enum Constants {
        static let stepOutside: CGFloat = 300.0
    }
    
    @ObservedObject var viewModel: GameViewModel
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }
        .onAppear {
            withAnimation(.showing) {
                viewModel.startNewGame()
            }
        }
    }
    
    @ViewBuilder
    private func body(for size: CGSize) -> some View {
        VStack {
            Grid(viewModel.shownCards) { card in
                CardView(card: card)
                    .padding()
                    .onTapGesture {
                        withAnimation {
                            viewModel.choose(card: card)
                        }
                    }
                    .transition(
                        AnyTransition.offset(
                            x: getOutside(for: size.width, out: Constants.stepOutside),
                            y: getOutside(for: size.width, out: Constants.stepOutside)))
                 
            }
            Button(action: {
                withAnimation(.showing) {
                    viewModel.deal3More()
                }
            }, label: { Text("Deal 3 More Cards") })
                .gray()
            Spacer()
            Button(action: {
                withAnimation(.showing) {
                    viewModel.startNewGame()
                }
            }, label: { Text("New Game") })
                .gray()
        }
    }
    
    /// Calculate random outsreen offset to start appearing animation
    /// - Parameters:
    ///   - side: `width` or `height` of the `view`
    ///   - out: max `step` from the screen which could be choosen.
    /// - Returns: <#description#>
    private func getOutside(for side: CGFloat, out: CGFloat) -> CGFloat {
        let leftRange = -2 * out ... -out
        let rightRange = side + out ... side + 2 * out
        
        return CGFloat.random(in: (Int.random(in: 0...1) == 0 ? leftRange : rightRange))
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = GameViewModel()
        return Group {
            GameView(viewModel: viewModel)
                
        }
    }
}
