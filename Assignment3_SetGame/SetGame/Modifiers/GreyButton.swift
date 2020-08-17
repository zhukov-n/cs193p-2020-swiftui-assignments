//
//  GreyButton.swift
//  GameSet
//
//  Created by Nikolay Zhukov on 7/17/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct GreyButton: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.gray)
            .foregroundColor(Color.white)
            .cornerRadius(12)
    }
    
}

extension Button {
    func gray() -> some View {
        modifier(GreyButton())
    }
}
