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
    var isCanceled = false
    
    // MARK: - Constructor
    init() {
        reachabilityManager?.startListening()
    }
    
    // MARK: - Instance Methods
    func retriveRepositories(_ name: String) {
        let firstPackage = Requests.Repository.ParametersData(query: name).queryString()
        let secondPackage = Requests.Repository.ParametersData(query: name, pageNumber: 2).queryString()
        isCanceled = false

        var firstBunch: [RepositoryModel]?
        var secondBunch: [RepositoryModel]?
        
        var firstError: Error?
        var secondError: Error?
        
        let downloadGroup = DispatchGroup()
        downloadGroup.enter()
        downloadGroup.enter()
        
        getRepositories(firstPackage) { (result, data) in
            switch result {
            case .success:
                firstBunch = data
            case .failure(let error):
                firstError = error
            }
            
            downloadGroup.leave()
        }
        
        getRepositories(secondPackage) { (result, data) in
            switch result {
            case .success:
                secondBunch = data
            case .failure(let error):
                secondError = error
            }

            downloadGroup.leave()
        }
        
        DispatchQueue.global(qos: .background).async {
            downloadGroup.wait()
            DispatchQueue.main.async {
                if (firstBunch ?? secondBunch) != nil {
                    self.remoteRequestHandler?.onRepositoriesRetrieved(name, firstBunch, secondBunch)
                } else if let error = firstError ?? secondError {
                    if !self.isCanceled {
                        self.remoteRequestHandler?.onError(error: error)
                    }
                }
            }
        }
    }
    
    func stopSearching() {
        isCanceled = true
        if #available(iOS 9.0, *) {
            Alamofire.SessionManager.default.session.getAllTasks { (tasks) in
                tasks.forEach{ $0.cancel() }
            }
        } else {
            Alamofire.SessionManager.default.session.getTasksWithCompletionHandler { (sessionDataTask, uploadData, downloadData) in
                sessionDataTask.forEach { $0.cancel() }
                uploadData.forEach { $0.cancel() }
                downloadData.forEach { $0.cancel() }
            }
        }
    }
    
    func isConnectionAvailable() -> Bool {
        return (reachabilityManager?.isReachable)!
    }
    
    // MARK: - Private
    fileprivate func getRepositories(_ parameters: String, completion: @escaping (_ result: Result<Any>, _ data: [RepositoryModel]?) -> Void ) {
        let req = [Requests.Repository.fetch.url, parameters].joined(separator: "?")
        Alamofire
            .request(req, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = Mapper<ResultModel>().map(JSONObject: response.result.value)
                    completion(response.result, result?.items)
                case .failure(_):
                    completion(response.result, nil)
                }
        }
    }
}

