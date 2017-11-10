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

class HTTPRequest: NSObject, URLSessionDataDelegate {

    public typealias SuccessHandler = (Data, HTTPURLResponse) -> Void
    public typealias FailureHandler = (Error) -> Void
    
    let url: URL
    let HTTPMethod: HTTPMethodType
    var request: URLRequest?
    
    // MARK: Initializers
    init(url: URL, method: HTTPMethodType) {
        self.url = url
        self.HTTPMethod = method
    }
    
    
    
}
