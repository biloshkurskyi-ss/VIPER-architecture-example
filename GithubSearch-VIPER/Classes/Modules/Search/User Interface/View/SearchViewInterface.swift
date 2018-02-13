//
//  SearchViewInterface.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol SearchViewInterface: class {
    var presenter: SearchPresenterProtocol? { get set }
        //PostListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showNoContentMessage(_ text: String)
    func showErrorPopUp(error text: String)
    func startSearching()
    func finishSearching()
    func reloadEntries()
    func showRepositories(_ data: UpcomingDisplayData)
}
