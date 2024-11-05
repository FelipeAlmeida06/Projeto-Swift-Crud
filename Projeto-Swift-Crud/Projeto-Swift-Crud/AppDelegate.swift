//
//  AppDelegate.swift
//  Projeto-Swift-Crud
//
//  Created by FELIPE on 05/11/24.
//

import UIKit
import Foundation
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        // Configurar Firebase
        FirebaseApp.configure()
        return true
    }
}
