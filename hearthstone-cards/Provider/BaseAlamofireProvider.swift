//
//  BaseAlamofireProvider.swift
//  hearthstone-cards
//
//  Created by Willian Junior Peres de Pinho on 19/12/22.
//

import Alamofire
import Foundation

public class BaseAlamofireProvider {
    
    let networkInterceptor: NetworkCheckerInterceptor?
        
    public init(networkInterceptor: NetworkCheckerInterceptor?){
        self.networkInterceptor = networkInterceptor
    }
    
    let sessionManager: Session = {
      let configuration = URLSessionConfiguration.af.default
      return Session(configuration: configuration, eventMonitors: [])
    }()
    
    
    public func request<Parameters: Encodable>(_ convertible: URLConvertible,
                          method: HTTPMethod = .get,
                          parameters: Parameters? = nil,
                          encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default,
                          headers: HTTPHeaders? = nil,
                          interceptor: RequestInterceptor? = nil,
                          timeoutInterval:Double = 60) -> DataRequest {
               
        let requestInterceptor: RequestInterceptor?
        
        if let interceptor = interceptor, let networkInterceptor = networkInterceptor {
            requestInterceptor = Interceptor(interceptors: [interceptor, networkInterceptor])
        } else {
            requestInterceptor = networkInterceptor
        }
        
        return sessionManager.request(convertible,method: method, parameters: parameters, encoder: encoder, headers: headers, interceptor: requestInterceptor){ $0.timeoutInterval = timeoutInterval }
   }

    public func request(_ convertible: URLConvertible,
                          method: HTTPMethod = .get,
                        headers: HTTPHeaders? = nil,
                          interceptor: RequestInterceptor? = nil,
                          timeoutInterval:Double = 60) -> DataRequest {
               
        return sessionManager.request(convertible,method: method, headers: headers, interceptor: interceptor ?? networkInterceptor){ $0.timeoutInterval = timeoutInterval }
   }
}
