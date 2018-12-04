//
//  TickerData.swift
//  KoinEx
//
//  Created by Satish Mavani on 03/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import UIKit

class TickerData: Codable {
    
    let prices : prices
    let stats : stats
}

struct stats: Codable {
    
    let inr : [String : details]
    let bitcoin : [String : details]
    let ether : [String : details]
    let ripple : [String : details]
}

struct details: Codable {
    
    let highest_bid: String
    let lowest_ask: String
    let last_traded_price: String
    let min_24hrs: String
    let max_24hrs: String
    let vol_24hrs: String
    let currency_full_form: String
    let currency_short_form: String
    let per_change: String
    let trade_volume: String
}

//====================================================

struct prices: Codable {
    
    let inr : [String:String]
    let bitcoin : [String:String]
    let ether : [String:String]
    let ripple :[String:String]
}
















