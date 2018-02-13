//
//  Repository+CoreDataProperties.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/12/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//
//

import Foundation
import CoreData


extension Repository {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Repository> {
        return NSFetchRequest<Repository>(entityName: "Repository")
    }

    @NSManaged public var id: Int32
    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var stars: Int32

}
