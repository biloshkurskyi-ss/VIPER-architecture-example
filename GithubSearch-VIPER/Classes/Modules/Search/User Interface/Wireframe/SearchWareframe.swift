//
//  SearchWareframe.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

let SearchControllerIdentifier = "SearchControllerIdentifier"

class SearchWareframe {
    
    var previewWireframe: PreviewWareframe?
    var searchPresenter: SearchPresenter?
    var rootWireframe: RootWireframe?
    var searchViewController: SearchViewController?
    
    func presentSearchInterfaceFromWindow(_ window: UIWindow) {
        let vc = searchViewControllerFromStoryboard()
        vc.presenter = searchPresenter
        searchViewController = vc
        searchPresenter?.userInterface = vc
        rootWireframe?.showRootViewController(vc, in: window)
    }
    
    func presentPreviewInterface(with url: String) {
        previewWireframe?.presentPreviewInterfaceFromViewController(searchViewController!, with: url)
    }
    
    func searchViewControllerFromStoryboard() -> SearchViewController {
        let storyboard = mainStoryboard()
        return storyboard.instantiateViewController(withIdentifier: SearchControllerIdentifier) as! SearchViewController
    }
    
    func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
}
