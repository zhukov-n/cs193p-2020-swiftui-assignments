//
//  ThemeStore.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 7/31/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import Combine
import Foundation

class ThemeStorage: ObservableObject {

    private enum Constants {
        static let untitled = "Untitled"
    }
    
    @Published private(set) var themes: [Theme<String>] = []
            
    func addTheme() {
        let theme = Theme<String>(emojies: ["🚗", "🚙", "🚌", "🚒"])
        themes.append(theme)
    }
    
    func removeTheme(_ theme: Theme<String>) {
        guard let index = themes.firstIndex(matching: theme) else { return }
        themes.remove(at: index)
    }
    
    func setName(_ name: String, theme: Theme<String>) {
        guard let index = themes.firstIndex(matching: theme) else { return }
        themes[index].name = name
    }
    
    func setCardCount(_ count: Int, theme: Theme<String>) {
        guard let index = themes.firstIndex(matching: theme) else { return }
        themes[index].numberToShow = count
    }
    
    func setEmojies(_ emojies: [String], theme: Theme<String>) {
        guard let index = themes.firstIndex(matching: theme) else { return }
        themes[index].emojies = emojies
    }
    
    func setNumberToShow(_ numberToShow: Int, theme: Theme<String>) {
        guard let index = themes.firstIndex(matching: theme) else { return }
        themes[index].numberToShow = numberToShow
    }
    
    private var autosave: AnyCancellable?
    
    init(themes: [Theme<String>]) {
        self.themes = themes
    }
    
    init?(name: String = "Default Name") {
        if let json = UserDefaults.standard.data(forKey: name) {
            themes = (try? JSONDecoder().decode([Theme<String>].self, from: json)) ?? []
        } else {
            themes = []
        }

        autosave = $themes.sink { themes in
            guard let newJson = try? JSONEncoder().encode(themes) else { return }
            UserDefaults.standard.set(newJson, forKey: name)
        }
    }
   
}
