//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Наджафов Араз on 07.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // - UI
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().tintColor = UIColor.black
        
        let navigationFont = UIFont(name: "American Typewriter", size: 20)
        let navigationFontAttributes = [NSAttributedString.Key.font : navigationFont]
        
        UINavigationBar.appearance().titleTextAttributes = navigationFontAttributes as [NSAttributedString.Key : Any]
        UIBarButtonItem.appearance().setTitleTextAttributes(navigationFontAttributes as [NSAttributedString.Key : Any], for: .normal)
        
        print("Приложение загрузилось!")
        return true
    }

}

