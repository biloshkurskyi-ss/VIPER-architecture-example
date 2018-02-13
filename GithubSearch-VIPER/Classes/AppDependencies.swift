//
//  AppDependencies.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import UIKit

class AppDependencies {
    
    // MARK: - Instance Properties
    var searchWareframe = SearchWareframe()
    
    // MARK: - View Lifecycle
    init() {
        configureDependencies()
    }
    
    //MARK: - Instance Methods
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        searchWareframe.presentSearchInterfaceFromWindow(window)
    }
    
    //  MARK: - Private
    fileprivate func configureDependencies() {
        let rootWireframe = RootWireframe()
        let previewWireframe = PreviewWareframe()
        let searchPresenter = SearchPresenter()
        
        let coreDataStore = CoreDataStore()
        let localDataManager = LocalDataManager()
        localDataManager.coreData = coreDataStore
        let remoteDataManager = RemoteDataManager()
        let searchInteractor = SearchInteractor(localDatamanager: localDataManager, remoteDatamanager: remoteDataManager)
        
        remoteDataManager.remoteRequestHandler = searchInteractor
        
        searchPresenter.searchInteractor = searchInteractor
        searchInteractor.presenter = searchPresenter
        searchPresenter.searchWareframe = searchWareframe
        
        searchWareframe.rootWireframe = rootWireframe
        searchWareframe.searchPresenter = searchPresenter
        searchWareframe.previewWireframe = previewWireframe
    }
}
