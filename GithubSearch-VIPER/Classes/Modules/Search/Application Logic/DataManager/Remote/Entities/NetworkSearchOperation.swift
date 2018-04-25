//
//  NetworkSearchOperation.swift
//  GithubSearch-VIPER
//
//  Created by Serhii on 4/18/18.
//  Copyright © 2018 Sergey Biloshkurskyi. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

typealias NetworkOperationCompletionHandlerType = ((_ response: Any?, _ error: Error?) -> ())

class NetworkSearchOperation: AsynchronousOperation {
    private let urlString: String!
    private var networkOperationCompletionHandler: NetworkOperationCompletionHandlerType?
    
    weak var request: Alamofire.Request?
    
    init(urlString: String, completionHandler: NetworkOperationCompletionHandlerType? = nil) {
        self.urlString = urlString
        self.networkOperationCompletionHandler = completionHandler
        
        super.init()
        
        self.queuePriority = .low
        self.qualityOfService = .background
    }
    
    override func main() {
        request = Alamofire
            .request(urlString, method: .get)
            .validate(statusCode: 200..<300)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let result = Mapper<ResultModel>().map(JSONObject: response.result.value)

                    self.networkOperationCompletionHandler?(result,nil)
                case .failure(let error):
                    self.networkOperationCompletionHandler?(nil, error)
                }

                self.networkOperationCompletionHandler = nil
                self.completeOperation()
        }
    }
    
    override func cancel() {
        super.cancel()
        request?.cancel()
    }
}
