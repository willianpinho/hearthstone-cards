//
//  NetworkCheckerManager.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Foundation
import Alamofire

public protocol NetworkCheckerManagerProtocol {
    var retryListener: (() -> (Void))? {set get}
    func hasInternetConnection() -> Bool
    func startObserverNetwork(completion: @escaping ((Bool) -> Void))
    func stopListener()
    func setRetryListener(completion: (() -> (Void))?)
    func showNetworkDisabledScreen()
}


public class NetworkCheckerManager: NetworkCheckerManagerProtocol {
    
    public var retryListener: (() -> (Void))? = nil
    
    let reachabilityManager = NetworkReachabilityManager()
    
    public func hasInternetConnection() -> Bool {
        return reachabilityManager?.isReachable ?? false
    }
    
    public func startObserverNetwork(completion: @escaping ((Bool) -> Void)) {
        reachabilityManager?.startListening(onUpdatePerforming: { _ in
            if let isReachable = self.reachabilityManager?.isReachable, isReachable == true {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    public func stopListener() {
        reachabilityManager?.stopListening()
    }
    
    public func setRetryListener(completion: (() -> (Void))?) {
        self.retryListener = completion
    }
    
    public func showNetworkDisabledScreen() {
        DispatchQueue.main.async {
            print("Sem internet")
        }
    }
}
