//
//  HTTPRequest+Error.swift
//  PunchLib
//
//  Created by Rafael Leandro on 11/14/17.
//  Copyright © 2017 Involves. All rights reserved.
//


extension HTTPRequest{
    
    class func responseErrorCode(for data: Data) -> Int? {
        //TODO: Parse API Response
        return 400
    }
    
    class func description(for status: Int, response string: String) -> String {
        var s = "HTTP Status \(status)"
        
        let description: String
        switch(status) {
        case 400:    description = "Bad Request"
        case 401:    description = "Unauthorized"
        case 402:    description = "Payment Required"
        case 403:    description = "Forbidden"
        case 404:    description = "Not Found"
        case 405:    description = "Method Not Allowed"
        case 406:    description = "Not Acceptable"
        case 407:    description = "Proxy Authentication Required"
        case 408:    description = "Request Timeout"
        case 409:    description = "Conflict"
        case 410:    description = "Gone"
        case 411:    description = "Length Required"
        case 412:    description = "Precondition Failed"
        case 413:    description = "Payload Too Large"
        case 414:    description = "URI Too Long"
        case 415:    description = "Unsupported Media Type"
        case 416:    description = "Requested Range Not Satisfiable"
        case 417:    description = "Expectation Failed"
        case 420:    description = "Enhance Your Calm"
        case 422:    description = "Unprocessable Entity"
        case 423:    description = "Locked"
        case 424:    description = "Failed Dependency"
        case 425:    description = "Unassigned"
        case 426:    description = "Upgrade Required"
        case 427:    description = "Unassigned"
        case 428:    description = "Precondition Required"
        case 429:    description = "Too Many Requests"
        case 430:    description = "Unassigned"
        case 431:    description = "Request Header Fields Too Large"
        case 432:    description = "Unassigned"
        case 500:    description = "Internal Server Error"
        case 501:    description = "Not Implemented"
        case 502:    description = "Bad Gateway"
        case 503:    description = "Service Unavailable"
        case 504:    description = "Gateway Timeout"
        case 505:    description = "HTTP Version Not Supported"
        case 506:    description = "Variant Also Negotiates"
        case 507:    description = "Insufficient Storage"
        case 508:    description = "Loop Detected"
        case 509:    description = "Unassigned"
        case 510:    description = "Not Extended"
        case 511:    description = "Network Authentication Required"
        default:    description = ""
        }
        
        if !description.isEmpty {
            s = s + ": " + description + ", Response: " + string
        }
        
        return s
    }
}
