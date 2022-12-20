//
//  NetworkCheckerInterceptor.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Alamofire

public class NetworkCheckerInterceptor: RequestInterceptor {
    
    let retryDelay: TimeInterval = 2
    var shouldCallRetry: Bool = false
    let networkCheckerManager:NetworkCheckerManagerProtocol?
    
    public init(networkCheckerManager: NetworkCheckerManagerProtocol?){
        self.networkCheckerManager = networkCheckerManager
    }
    
    public func adapt(_ urlRequest: URLRequest, for session: Session, completion: @escaping (Result<URLRequest, Error>) -> Void) {
        var urlRequest = urlRequest
        
        completion(.success(urlRequest))
    }
    
    
    public func retry(_ request: Request, for session: Session, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        let hasNetwork = networkCheckerManager?.hasInternetConnection() ?? false
        if !hasNetwork {
            networkCheckerManager?.showNetworkDisabledScreen()
            networkCheckerManager?.setRetryListener(completion: {
                self.shouldCallRetry ? completion(.retry) : completion(.doNotRetry)
            })
        } else {
            guard let response = request.task?.response as? HTTPURLResponse else {
                return completion(.doNotRetryWithError(error))
            }
            if response.statusCode == 401 || checkUnauthenticatedError(error: error) {
                DispatchQueue.main.async {
                    print("401 Error")
                }
            }
            completion(.doNotRetry)
        }
    }
    
    func checkUnauthenticatedError(error: Error) -> Bool {
        if let error = error as? AFError,
           case .responseSerializationFailed(let reason) = error,
           case .customSerializationFailed(let error) = reason,
           error is UnauthenticatedError
        {
           return true
        }
        
        return false
    }
    
    func notifyAll(shouldRetry: Bool = false) {
        shouldCallRetry = shouldRetry
        if let completion = networkCheckerManager?.retryListener {
            completion()
        }
    }
}
