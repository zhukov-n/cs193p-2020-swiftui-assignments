//
//  Diamond.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/16/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct Diamond: Shape {
    
    func path(in rect: CGRect) -> Path {
        var p = Path()

        let top = CGPoint(x: rect.midX, y: rect.minY)
        p.move(to: top)
        p.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        p.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        p.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
        p.addLine(to: top)
        
        return p
    }

}

struct Diamond_Previews: PreviewProvider {
    static var previews: some View {
        Diamond()
    }
}
