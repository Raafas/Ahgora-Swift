//
//  HTTPRequest.swift
//  PunchLib
//
//  Created by Rafael Leandro on 10/11/17.
//  Copyright © 2017 Involves. All rights reserved.
//
import Foundation
import CoreFoundation
import Dispatch

public enum HTTPMethodType: String {
    case OPTIONS
    case GET
    case HEAD
    case POST
    case PUT
    case DELETE
    case TRACE
    case CONNECT
}

class HTTPRequest: NSObject {

    public typealias SuccessHandler = (Data, HTTPURLResponse) -> Void
    public typealias FailureHandler = (Error) -> Void
    
    let url: URL
    let HTTPMethod: HTTPMethodType
    var request: URLRequest?
    var dataTask: URLSessionDataTask?
    var headers: Dictionary<String, String> = [:]
    var parameters: Dictionary<String, Any>
    var response: HTTPURLResponse?
    var responseData: Data = Data()
    var successHandler: SuccessHandler?
    var failureHandler: FailureHandler?
    
    // MARK: Initializers
    init(url: URL, method: HTTPMethodType, parameters: Dictionary<String, Any> = [:]) {
        self.url = url
        self.HTTPMethod = method
        self.parameters = parameters
    }
    
    init(request: URLRequest) throws {
        self.request = request
        guard let url = request.url else { throw NSError(domain: "Invalid URL", code: 0, userInfo: nil) }
        guard let method = request.httpMethod else { throw NSError(domain: "", code: 0, userInfo: nil) }
        self.url = url
        self.HTTPMethod = HTTPMethodType(rawValue: method) ?? .GET
        self.parameters = [:]
    }
    
    func start(){
        if (request == nil){
            self.request = URLRequest(url: self.url)
            self.request?.httpMethod = self.HTTPMethod.rawValue
            
            for (key, value) in headers{
                self.request?.setValue(value, forHTTPHeaderField: key)
            }
        }
        DispatchQueue.main.async {
            guard let request = self.request else { return }
            let session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
            self.dataTask = session.dataTask(with: request)
            self.dataTask?.resume()
            #if os(iOS)
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
            #endif
        }
    }
    
    public func stop() {
        guard let dataTask = self.dataTask else { return }
        dataTask.cancel()
    }
}
