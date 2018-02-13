//
//  LocalDataManager.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class LocalDataManager: LocalDataManagerProtocol {

    var coreData: CoreDataStore?

    func retrieveRepository(_ name: String) throws -> [RepositoryModel] {
        guard let managedOC = coreData?.managedObjectContext else {
            throw LocalPersistenceError.managedObjectContextNotFound
        }
        
        let fetchRequest: NSFetchRequest<Search>  = NSFetchRequest(entityName: String(describing: Search.self))
        let predicate = NSPredicate(format: "search == %@", name)
        fetchRequest.predicate = predicate
        
        do {
            if let search = try managedOC.fetch(fetchRequest).first  {
                let repositories = self.repositoryItemsFromDataStoresEntries(Array(search.search_repository))
                return repositories
            } else {
                throw LocalPersistenceError.objectNotFound
            }
        } catch {
            throw LocalPersistenceError.objectNotFound
        }
    }
    
    func saveRepositories(_ repositories: [RepositoryModel], for query: String) throws {
        guard let managedOC = coreData?.managedObjectContext else {
            throw LocalPersistenceError.managedObjectContextNotFound
        }

        let repositoriesModels = repositories.map { repository -> Repository in
            let obj = Repository(context: managedOC)
            obj.id = Int32(repository.id)
            obj.name = repository.name
            obj.url = repository.url
            obj.stars = Int32(repository.stars)
            return obj
        }
        
        let search = Search(context: managedOC)
        search.search = query
        repositoriesModels.forEach {
            search.addToSearch_repository($0)
        }

        do {
            try managedOC.save()
        } catch  {
            print("\(error.localizedDescription)")
        }
    }
    
    // MARK: - Private
    fileprivate func repositoryItemsFromDataStoresEntries(_ entries: [Repository]) -> [RepositoryModel] {
        let items: [RepositoryModel] = entries.map { entry in
            RepositoryModel(id: Int(entry.id), name: entry.name!, url: entry.url!, stars: Int(entry.stars))
        }
        return items.sorted(by: { $0.stars > $1.stars })
    }
}

