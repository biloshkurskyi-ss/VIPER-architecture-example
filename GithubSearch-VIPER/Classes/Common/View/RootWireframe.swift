//
//  RootWireframe.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

class RootWireframe {
    func showRootViewController(_ vc: UIViewController, in window: UIWindow) {
        let navigationController = navigationControllerFromWindow(window)
        navigationController.viewControllers = [vc]
    }
    
    func navigationControllerFromWindow(_ window: UIWindow) -> UINavigationController {
        return window.rootViewController as! UINavigationController
    }
}
