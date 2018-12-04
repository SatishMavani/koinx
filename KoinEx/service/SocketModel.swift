//
//  SocketModel.swift
//  KoinEx
//
//  Created by Satish Mavani on 04/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import Foundation

class SocketModel: Codable {
    
    let event: String
    let message : message
    let channel : String
    
}

struct message: Codable {
    let data : data
    let info : info
}

struct data: Codable {
    
    let inrmap : [String : details]
    
}

struct info: Codable {
    
    let server_time: String
    let base_currency: String
    let inrmap : [String : details]
}


