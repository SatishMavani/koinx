//
//  SocketConnection.swift
//  KoinEx
//
//  Created by Satish Mavani on 04/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import Foundation
import Starscream

class SocketConnection: WebSocketDelegate {
    
    var socket = WebSocket(url: URL(string: WEBSOCKET_ENDPOINT)!, protocols: ["chat"])
   
    func connectSocket()  {
        socket.connect()
    }
    
    func websocketDidConnect(socket: WebSocketClient) {
        let dict1 = ["event" : "pusher:subscribe", "data":["channel" : "my-channel-ticker-inr"] ] as [String : Any]
        
        let jsonData = try! JSONSerialization.data(withJSONObject: dict1, options: [])
        let decoded = String(data: jsonData, encoding: .utf8)!
        socket.write(string: decoded)
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print(text)
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // Noop - Must implement since it's not optional in the protocol
    }
}

