//
//  CoinDetailViewController.swift
//  KoinEx
//
//  Created by Satish Mavani on 04/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import UIKit

class CoinDetailViewController: UIViewController {
    
    var detailData: details!
    @IBOutlet weak var tableView: UITableView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource=self
    }
}

extension CoinDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 8
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL" )
        
        if cell == nil {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "CELL")
        }
        
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "LAST TRADE PRICE"
            cell?.detailTextLabel?.text = detailData.last_traded_price
        case 1:
            cell?.textLabel?.text = "HIGH(24 H)"
            cell?.detailTextLabel?.text = detailData.highest_bid
        case 2:
            cell?.textLabel?.text = "LOW(24 H)"
            cell?.detailTextLabel?.text = detailData.lowest_ask
        case 3:
            cell?.textLabel?.text = "HIGHEST BID"
            cell?.detailTextLabel?.text = detailData.highest_bid
        case 4:
            cell?.textLabel?.text = "LOWEST ASK"
            cell?.detailTextLabel?.text = detailData.lowest_ask
        case 5:
            let percentChange = Double(detailData.per_change)
            cell?.textLabel?.text = "CHANGE (24 H)"
            cell?.detailTextLabel?.text = String(format: "%.2f", percentChange ?? 0.0) + "%"
        case 6:
            cell?.textLabel?.text = "VOLUME (24 H)"
            cell?.detailTextLabel?.text = detailData.vol_24hrs
        case 7:
            cell?.textLabel?.text = "TRADE VOLUME"
            cell?.detailTextLabel?.text = detailData.trade_volume
        default:
            cell?.textLabel?.text = "No data"
            cell?.detailTextLabel?.text = "No data"
        }
        return cell!
    }
}
