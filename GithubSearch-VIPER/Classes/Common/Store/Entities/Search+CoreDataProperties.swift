//
//  Search+CoreDataProperties.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//
//

import Foundation
import CoreData


extension Search {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Search> {
        return NSFetchRequest<Search>(entityName: "Search")
    }

    @NSManaged public var search: String?
    @NSManaged public var search_repository: Set<Repository>

}

// MARK: Generated accessors for search_repository
extension Search {

    @objc(addSearch_repositoryObject:)
    @NSManaged public func addToSearch_repository(_ value: Repository)

    @objc(removeSearch_repositoryObject:)
    @NSManaged public func removeFromSearch_repository(_ value: Repository)

    @objc(addSearch_repository:)
    @NSManaged public func addToSearch_repository(_ values: NSSet)

    @objc(removeSearch_repository:)
    @NSManaged public func removeFromSearch_repository(_ values: NSSet)

}
