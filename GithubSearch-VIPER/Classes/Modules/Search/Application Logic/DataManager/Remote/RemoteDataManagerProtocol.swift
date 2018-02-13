//
//  RemoteDataManagerProtocol.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol RemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retriveRepositories(_ name: String)
    func stopSearching()
    func isConnectionAvailable() -> Bool
}

protocol RemoteDataManagerOutputProtocol: class {
    
    // REMOTEDATAMANAGER -> INTERACTOR
    func onRepositoriesRetrieved(_ name: String, _ firstBunch: [RepositoryModel]?, _ secondBunch: [RepositoryModel]?)
    func onError(error: Error)
}
