//
//  AppDelegate.swift
//  libffiiOSDemo
//
//  Created by Yanni Wang on 20/4/21.
//

import UIKit
import libffi_iOS

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        _ = ffi_cif()
        return true
    }


}

