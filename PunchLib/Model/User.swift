//
//  Register.swift
//  PontoApp
//
//  Created by Rafael Leandro on 08/11/17.
//  Copyright © 2017 Rafael Leandro. All rights reserved.
//

public struct User: Encodable{
    var id: String
    var password: String
    var companyId: String
    
    enum CodingKeys: String, CodingKey {
        case id = "matricula"
        case password = "senha"
        case companyId = "empresa"
    }
    
    public init(id: String, password: String, companyId: String) {
        self.id = id
        self.password = password
        self.companyId = companyId
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(password, forKey: .password)
        try container.encode(companyId, forKey: .companyId)
    }
}

