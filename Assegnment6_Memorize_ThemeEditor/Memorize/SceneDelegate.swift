//
//  SceneDelegate.swift
//  Memorize
//
//  Created by Nikolay Zhukov on 5/28/20.
//  Copyright © 2020 Nikolay Zhukov. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let store = ThemeStorage() ?? ThemeStorage(themes: [])
        let contentView = ThemeChooserView()
            .environmentObject(store)
        
        // Use a UIHostingController as window root view controller.
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

