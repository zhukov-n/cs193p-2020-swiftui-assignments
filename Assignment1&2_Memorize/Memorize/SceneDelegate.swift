//
//  SceneDelegate.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/28/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import SwiftUI

class ThemeStorage {
    
    private let `default`: Theme<String>
    private let themes: [Theme<String>]
    
    init() {
        let animals = Theme(name: "Animals", emojies: ["🐼", "🐔","🦄", "🦕", "🦨"], color: .yellow)
        let sports = Theme(name: "Sports", emojies: [ "🏀", "🏈", "⚾", "🥎", "🎽"], color: .red)
        let faces = Theme(name: "Faces", emojies: ["😀", "😢", "😉", "😓", "☹️", "😱"], color: .green)
        
        `default` = animals
        themes = [animals, sports, faces]
    }
    
    var randomTheme: Theme<String> { themes.randomElement() ?? `default` }
    
}

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let theme = ThemeStorage().randomTheme
        let model = MemoryGame<String>(with: theme)
        let game = EmojiMemoryGame(model: model)
        let contentView = EmojiGameMemoryView(viewModel: game)

        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

