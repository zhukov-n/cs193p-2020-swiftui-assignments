//
//  ThemeChooserView.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 7/31/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import SwiftUI

struct ShowThemeEditorView: View {
    
    var theme: Theme<String>
    var editingMode: EditMode
    
    @State private var showThemeEditor = false
    @EnvironmentObject var store: ThemeStorage
    
    var body: some View {
        HStack {
            if self.editingMode.isEditing {
                Text("Edit")
                    .foregroundColor(.blue)
                    .onTapGesture {
                        self.showThemeEditor = true
                }
                .popover(isPresented: self.$showThemeEditor) {
                    ThemeEditor(theme: self.theme, isShowing: self.$showThemeEditor) { newTheme in
                        self.store.setName(newTheme.name, theme: self.theme)
                        self.store.setCardCount(newTheme.numberToShow, theme: self.theme)
                        self.store.setEmojies(newTheme.emojies, theme: self.theme)
                    }
                        .environmentObject(self.store)
                        .frame(minWidth: 300, minHeight: 500)
                }
            }
        }
    }
}

struct ThemeChooserView: View {

    private enum Constants {
        static let title = "Memorize"
    }

    @EnvironmentObject var store: ThemeStorage
    @State private var editingMode: EditMode = .inactive

    var body: some View {
        NavigationView {
            List {
                ForEach(store.themes) { theme in
                    NavigationLink(destination: EmojiGameMemoryView(theme: theme)) {
                        HStack {
                            ShowThemeEditorView(theme: theme, editingMode: self.editingMode)
                                .environmentObject(self.store)
                            Text(theme.name)
                            Spacer()
                            Rectangle()
                                .aspectRatio(1, contentMode: .fit)
                                .foregroundColor(Color(theme.color))
                                .frame(height: 44)
                            VStack {
                                Text("Count: \(theme.emojies.count)")
                                HStack {
                                    ForEach(theme.emojies.prefix(3).map { String($0) }, id: \.self) { emoji in
                                        Text(emoji)
                                    }
                                }
                            }
                        }
                    }
                }
                .onDelete { indexSet in
                    indexSet.map { self.store.themes[$0] }.forEach { theme in
                        self.store.removeTheme(theme)
                    }
                }
            }
            .navigationBarTitle(Constants.title)
            .navigationBarItems(
                leading: Button(
                    action: {
                        self.store.addTheme()
                }, label: {
                    Image(systemName: "plus").imageScale(.large)
                }),
                trailing: EditButton())
 
            .environment(\.editMode, $editingMode)
        }
    }
}

struct ThemeChooser_Previews: PreviewProvider {
    static var previews: some View {
        ThemeChooserView()
    }
}
