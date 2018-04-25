//
//  Errors.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation

enum LocalPersistenceError: Error {
    case managedObjectContextNotFound
    case couldNotSaveObject
    case objectNotFound
}

enum RemotePersistenceError: Error {
    case undefined
    case cancelled
    case missingResult(String)
    case missingConnection
}
