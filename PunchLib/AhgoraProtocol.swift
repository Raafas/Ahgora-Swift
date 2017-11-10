//
//  AhgoraProtocol.swift
//  PunchLib
//
//  Created by Rafael Leandro on 10/11/17.
//  Copyright © 2017 Involves. All rights reserved.
//

import Foundation

protocol AhgoraProtocol {
    
    func get() -> HTTPRequest
    func post() -> HTTPRequest
}
