//
//  HTTPRequest+URLSession.swift
//  PunchLib
//
//  Created by Rafael Leandro on 11/14/17.
//  Copyright © 2017 Involves. All rights reserved.
//

extension HTTPRequest: URLSessionDelegate{
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        #if os(iOS)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        #endif
        
        defer {
            session.finishTasksAndInvalidate()
        }
        
        if let error = error {
            self.failureHandler?(error)
            return
        }
        
        guard let code = response?.statusCode else { return }
        guard let headers = response?.allHeaderFields else { return }
        guard let responseString = String(data: responseData, encoding: String.Encoding.utf8) else { return }
        let errorCode = 0
        let localizedDescription = HTTPRequest.description(for: code, response: responseString)
        let error = AhgoraError(message: localizedDescription, kind: .urlResponseError(status: code, headers: headers, errorCode: errorCode))
        self.failureHandler?(error)
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.response = response as? HTTPURLResponse
        self.responseData.count = 0
        completionHandler(.allow)
    }
}
