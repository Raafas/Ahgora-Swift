//
//  PontoApi.swift
//  PontoApp
//
//  Created by Rafael Leandro on 08/11/17.
//  Copyright © 2017 Rafael Leandro. All rights reserved.
//

import Foundation

fileprivate enum Ahgora{
    case login
    case verify
    case record
    case identity
    
    var url: String{
        switch self {
        case .login: return "https://www.ahgora.com.br/externo/login"
        case .verify: return "https://www.ahgora.com.br/batidaonline/verifyIdentification"
        case .record: return "https://www.ahgora.com.br/externo/batidas"
        case .identity: return "https://www.ahgora.com.br/batidaonline/defaultComputer?c="
        }
    }
}

public class AhgoraApi{
    
    public typealias SuccessHandler = ([String]) -> Void
    public typealias FailureHandler = (_ error: Error) -> Void
    
    
    
    public init() { }
    
    @discardableResult
    public func apiCall(path: String, baseUrl: String, method: HTTPMethodType, parameters:  Dictionary<String, Any>) -> HTTPRequest {
        
    }
    
    public func Login(user: User, completion: @escaping (_ success: String?) -> Void ) {
        let baseUrl = Ahgora.identity.url.appending(user.companyId)
        guard let url = URL(string: baseUrl) else{ return }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let _ = data, error == nil else {
                completion(nil)
                return
            }

            if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                completion(nil)
            }

            let json = try? JSONSerialization.jsonObject(with: data!, options: [])
            if let dictionary = json as? [String: Any] {
                guard let identity = dictionary["identity"] as? String else { return }
                completion(identity)
            }
        }
        task.resume()
    }
    
    public func Register(user: User, token: String, completion: @escaping (_ success: [String]) -> Void){
        guard let url = URL(string: Ahgora.verify.url) else{ return }
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        
        let dict = ["account": user.id, "password": user.password, "identity": token] as [String: String]
        if let jsonData = try? JSONSerialization.data(withJSONObject: dict, options: []) {
            var request = URLRequest(url: url)
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            request.httpBody = jsonData
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                guard let _ = data, error == nil else {
                    completion([])
                    return
                }
                
                if let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 {
                    completion([])
                }
                
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                if let dictionary = json as? [String: Any] {
                    guard let registers = dictionary["batidas_dia"] as? [String] else { return }
                    completion(registers)
                }
            }
            task.resume()
        }
    }
    
}

