//
//  SearchPresenter.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

class SearchPresenter: SearchPresenterProtocol  {

    // MARK: - Instance Variable
    weak var userInterface: SearchViewInterface?
    var searchInteractor: SearchInteractorInputProtocol?
    var searchWareframe: SearchWareframe?
    
    // MARK: - Instance Methods
    func viewDidLoad() {
        userInterface?.showNoContentMessage("1. Please enter some text in search bar\n2. Tap Search button")
    }
    
    func showRepositoryDetail(_ repository: UpcomingDisplayItem) {
        if (searchInteractor?.isConnectionAvailable())! {
            searchWareframe?.presentPreviewInterface(with: repository.url)
        } else {
            onError(RemotePersistenceError.missingConnection)
        }
    }
    
    func retrieveRepository(_ name: String) {
        userInterface?.startSearching()
        searchInteractor?.retrieveRepositories(name)
    }
    
    func stopSearching() {
        searchInteractor?.stopSearching()
        userInterface?.finishSearching()
    }
    
    func cancelSearching() {
        searchInteractor?.stopSearching()
        userInterface?.finishSearching()
        userInterface?.showNoContentMessage("1. Please enter some text in search bar\n2. Tap Search button")
    }
}

// MARK: - SearchInteractorOutputProtocol
extension SearchPresenter: SearchInteractorOutputProtocol {

    func didRetrievePosts(_ posts: [RepositoryModel]) {
        let displayData = UpcomingDisplayData(rows: posts.map { (obj: RepositoryModel) -> UpcomingDisplayItem in
            let obj = UpcomingDisplayItem(title: obj.name.trunc(length: 30), url: obj.url)
            return obj
            })
        userInterface?.showRepositories(displayData)
        userInterface?.finishSearching()
    }
    
    func onError(_ error: Error) {
        userInterface?.finishSearching()
        
        switch error {
        case RemotePersistenceError.missingResult(let name):
            userInterface?.showErrorPopUp(error: "Missing result for repo: \(name)")
        case RemotePersistenceError.missingConnection:
            userInterface?.showErrorPopUp(error: "Failed internet connection.\nPlease try again later.")
        default:
            userInterface?.showErrorPopUp(error: "Change repository name or try again later")
        }
    }
}
