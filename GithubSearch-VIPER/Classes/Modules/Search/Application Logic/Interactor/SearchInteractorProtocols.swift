//
//  SearchInteractorIO.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol SearchInteractorInputProtocol: class {
    var presenter: SearchInteractorOutputProtocol? { get set }
    var localDatamanager: LocalDataManagerProtocol? { get set }
    var remoteDatamanager: RemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrieveRepositories(_ text: String)
    func stopSearching()
    func isConnectionAvailable() -> Bool
}

protocol SearchInteractorOutputProtocol: class {
    
    // INTERACTOR -> PRESENTER
    func didRetrievePosts(_ posts: [RepositoryModel])
    func onError(_ error: Error)
}
