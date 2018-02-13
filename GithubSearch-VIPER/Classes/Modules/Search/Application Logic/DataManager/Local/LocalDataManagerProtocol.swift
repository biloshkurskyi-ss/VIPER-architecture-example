//
//  LocalDataManagerProtocol.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

protocol LocalDataManagerProtocol {
    var coreData: CoreDataStore? { get set }
    
    func retrieveRepository(_ name: String) throws -> [RepositoryModel]
    func saveRepositories(_ repositories: [RepositoryModel], for query: String) throws
}
