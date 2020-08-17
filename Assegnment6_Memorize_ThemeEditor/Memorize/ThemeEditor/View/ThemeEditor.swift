//
//  ThemeEditor.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 7/31/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

extension String: Identifiable {
    public var id: String { self }
}

fileprivate struct RemoveEmojiSection: View {
    @Binding var theme: Theme<String>
    
    var body: some View {
        Section(header: Text("Remove Emoji")) {
            Grid(self.theme.emojies) { emoji in
                Text(emoji).font(Font.system(size: self.fontSize))
                    .onTapGesture {
                        let chars = emoji.map { String($0) }
                        for item in chars {
                            guard let i = self.theme.emojies.firstIndex(of: item) else { continue }
                            self.theme.emojies.remove(at: i)
                        }
                }
            }
            .frame(height: self.height)
        }
    }
    
    // MARK: - Drawing Constants
    
    var height: CGFloat {
        CGFloat((theme.emojies.count - 1) / 6) * 70 + 70
    }
    
    let fontSize: CGFloat = 40
}

struct ThemeEditor: View {
    @State var theme: Theme<String>
    @Binding var isShowing: Bool
    @State private var themeName: String = ""
    @State private var emojisToAdd: String = ""
    
    var onChanged: ((Theme<String>) -> ())?
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Text("Theme Editor").font(.headline).padding()
                HStack {
                    Spacer()
                    Button(action: {
                        self.hideKeyboard()
                        self.isShowing = false
                        self.onChanged?(self.theme)
                        
                    }, label: { Text("Done") }).padding()
                }
            }
            Divider()
            Form {
                Section {
                    TextField("Theme Name", text: $themeName, onEditingChanged: { began in
                        if !began {
                            self.theme.name = self.themeName
                        }
                    })
                    TextField("Add Emoji", text: $emojisToAdd, onEditingChanged: { began in
                        if !began {
                            self.theme.emojies = Array(Set(self.emojisToAdd.map { String($0) } + self.theme.emojies))
                            self.emojisToAdd = ""
                        }
                    })
                }

                RemoveEmojiSection(theme: $theme)
                Section(header: Text("Card Count")) {
                    Stepper(onIncrement: {
                        if self.theme.numberToShow <= self.theme.emojies.count {
                            self.theme.numberToShow += 1
                        }
                    }, onDecrement: {
                        if self.theme.numberToShow > 2 {
                            self.theme.numberToShow -= 1
                        }
                    }) {
                        Text("Pairs \(self.theme.numberToShow)")
                    }
                }
            }

        }
        .onAppear { self.themeName = self.theme.name }
    }

}
