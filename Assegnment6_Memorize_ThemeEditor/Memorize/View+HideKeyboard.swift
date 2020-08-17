//
//  View+HideKeyboard.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 8/17/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
