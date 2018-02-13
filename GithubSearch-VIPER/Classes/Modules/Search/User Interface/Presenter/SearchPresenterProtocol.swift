//
//  SearchPresenterProtocol.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol SearchPresenterProtocol: class {
    
    var userInterface: SearchViewInterface? { get set }
    var searchInteractor: SearchInteractorInputProtocol? { get set }
    var searchWareframe: SearchWareframe? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
    func showRepositoryDetail(_ repository: UpcomingDisplayItem)
    func retrieveRepository(_ name: String)
    func cancelSearching()
    func stopSearching()
}
