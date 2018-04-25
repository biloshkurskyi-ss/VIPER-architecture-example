//
//  RemoteDataManager.swift
//  GithubSearch-VIPER
//
//  Created by Sergey Biloshkurskyi on 2/11/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

class RemoteDataManager: RemoteDataManagerInputProtocol {
    
    // MARK: - Injections
    weak var remoteRequestHandler: RemoteDataManagerOutputProtocol?
    
    // MARK: - Instance Variable
    let reachabilityManager = NetworkReachabilityManager()
    
    // MARK: - Private Variable
    private var operationQueue: OperationQueue
    
    // MARK: - Constructor
    init() {
        reachabilityManager?.startListening()
        
        operationQueue = OperationQueue.init()
        operationQueue.maxConcurrentOperationCount = 2
        operationQueue.qualityOfService = .background
    }
    
    // MARK: - Instance Methods
    func retriveRepositories(_ name: String) {
        var packages = [ResultModel?]()
        var errors = [Error]()
        var operations = [Operation]()
        
        let urls = [[Requests.Repository.fetch.url, Requests.Repository.ParametersData(query: name).queryString()].joined(separator: "?"),
                    [Requests.Repository.fetch.url, Requests.Repository.ParametersData(query: name, pageNumber: 2).queryString()].joined(separator: "?")]
        
        urls.forEach { (stringUrl) in
            let operation = NetworkSearchOperation(urlString: stringUrl) { (responseObject, error) in
                guard let responseObject = responseObject as? ResultModel else {
                    packages.append(nil)
                    if let error = error {
                        errors.append(error)
                    }
                    return
                }
                packages.append(responseObject)
            }
            operations.append(operation)
        }
        
        DispatchQueue.global(qos: .background).async {
            self.operationQueue.addOperations(operations, waitUntilFinished: true)
            
            let list = packages.compactMap { return $0?.items }.flatMap { $0 }
            
            DispatchQueue.main.async {
                
                if !list.isEmpty { //process items
                    self.remoteRequestHandler?.onRepositoriesRetrieved(name, list)
                } else if !errors.isEmpty { //process errors
                    if self.isCanseled(errors) {
                        self.remoteRequestHandler?.onError(error: RemotePersistenceError.cancelled)
                    } else {
                        self.remoteRequestHandler?.onError(error: errors.first!)
                    }
                } else { //no items no errors
                    self.remoteRequestHandler?.onRepositoriesRetrieved(name, list)
                }
            }
        }
    }
    
    func stopSearching() {
        operationQueue.cancelAllOperations()
    }
    
    func isConnectionAvailable() -> Bool {
        return (reachabilityManager?.isReachable)!
    }
    
    // MARK: - Private
    fileprivate func isCanseled(_ errors: [Error]) -> Bool {
        for error in errors {
            if error.localizedDescription == "cancelled" {
                return true
            }
        }
        return false
    }
}

