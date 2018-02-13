//
//  SearchInteractor.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol {

    // MARK: - Instance Variable
    weak var presenter: SearchInteractorOutputProtocol?
    var localDatamanager: LocalDataManagerProtocol?
    var remoteDatamanager: RemoteDataManagerInputProtocol?
    
    // MARK: - Constructors
    init(localDatamanager: LocalDataManagerProtocol, remoteDatamanager: RemoteDataManagerInputProtocol) {
        self.localDatamanager = localDatamanager
        self.remoteDatamanager = remoteDatamanager
    }
    
    // MARK: - Instance Methods
    func retrieveRepositories(_ text: String) {
        do {
            if let repositories = try localDatamanager?.retrieveRepository(text), !repositories.isEmpty {
                presenter?.didRetrievePosts(repositories)
            } else {
                remoreSearch(text)
            }
        } catch LocalPersistenceError.objectNotFound {
            remoreSearch(text)
        } catch {
            presenter?.onError(error)
        }
    }
    
    func stopSearching() {
        remoteDatamanager?.stopSearching()
    }
    
    func isConnectionAvailable() -> Bool {
        return (remoteDatamanager?.isConnectionAvailable())!
    }
    
    // MARK: - Private
    fileprivate func remoreSearch(_ text: String) {
        if isConnectionAvailable() {
            remoteDatamanager?.retriveRepositories(text)
        } else {
            presenter?.onError(RemotePersistenceError.missingConnection)
        }
    }
}

extension SearchInteractor: RemoteDataManagerOutputProtocol {

    func onRepositoriesRetrieved(_ name: String, _ firstBunch: [RepositoryModel]?, _ secondBunch: [RepositoryModel]?) {
        let bunch = [firstBunch, secondBunch].flatMap { $0 }.flatMap { $0 }
        if !bunch.isEmpty {
            do {
                try localDatamanager?.saveRepositories(bunch, for: name)
            } catch {
                print(error)
            }
            
            presenter?.didRetrievePosts(bunch)
        } else {
            presenter?.onError(RemotePersistenceError.missingResult(name))
        }
    }
    
    func onError(error: Error) {
        presenter?.onError(error)
    }
}
