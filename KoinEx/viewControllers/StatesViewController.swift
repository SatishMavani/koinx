//
//  StatesViewController.swift
//  KoinEx
//
//  Created by Satish Mavani on 03/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import UIKit
import Starscream

class StatesViewController: UIViewController {
 
    var tickerData :TickerData!
    var socketModel :SocketModel!
    var dataDic : [String: details] = [:]
    var socketConnection : SocketConnection!
    var socket = WebSocket(url: URL(string: WEBSOCKET_ENDPOINT)!, protocols: ["chat"])
    var tickerCount = 1
  
    @IBOutlet weak var segCoin: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    
  override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.downloadTickerData()
    }
    
    func downloadTickerData(){
        
        let sharedSession = URLSession.shared
        
        if let url = URL(string: BASE_URL) {
            // Create Request
            let request = URLRequest(url: url)
            
            // Create Data Task
            sharedSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                
                if error != nil {
                    print(error!.localizedDescription)
                }
                
                guard let data = data else { return }
                //Implement JSON decoding and parsing
                do {
                    //Decode retrived data with JSONDecoder and assing type of Article object
                    self.tickerData = try JSONDecoder().decode(TickerData.self, from: data)
                    self.dataDic = self.tickerData.stats.inr
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.socket.delegate = self
                        self.socket.connect()
                    }
                    
                } catch let jsonError {
                    print(jsonError)
                }
            }).resume()
        }
    }
    
    @IBAction func selectionChanged(_ sender: UISegmentedControl) {
       
        switch sender.selectedSegmentIndex {
        case 0:
            dataDic = self.tickerData.stats.inr
        case 1:
            dataDic = self.tickerData.stats.bitcoin
        case 2:
            dataDic = self.tickerData.stats.ether
        case 3:
            dataDic = self.tickerData.stats.ripple
        default:
            dataDic = self.tickerData.stats.inr
        }
        self.tableView.reloadData()
    }
}

extension StatesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return dataDic.keys.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "coinListTableViewCell", for: indexPath) as? coinListTableViewCell {
            
            let componentArray = Array(dataDic.keys)
            let name: String = componentArray[indexPath.row]
            let data = dataDic[name]! as! details
            let percentChange = Double(data.per_change)
            
            cell.coinName.text = String(format: "\(data.currency_full_form) (%@)",data.currency_short_form)
            cell.lblLatestPrice.text =  "Rs \(data.last_traded_price)"
            cell.percentChange.text = String(format: "%.2f", percentChange ?? 0.0) + "%"
            cell.baseView.layer.borderColor = UIColor.blue.cgColor
            cell.baseView.layer.borderWidth = 1
            return cell
            
        } else {
            return coinListTableViewCell()
        }
    }
    
    
}


extension StatesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destView = segue.destination as! CoinDetailViewController
        let indexpath = self.tableView.indexPathForSelectedRow!
        let componentArray = Array(dataDic.keys)
        let name: String = componentArray[indexpath.row]
        let data = dataDic[name]! as! details
        destView.detailData = data
        tableView.deselectRow(at: indexpath, animated: true)
        destView.navigationItem.title = name
        
    }
}

extension StatesViewController: WebSocketDelegate {
   func websocketDidConnect(socket: WebSocketClient) {
        let dict = ["event" : "pusher:subscribe", "data":["channel" : "my-channel-ticker-inr"] ] as [String : Any]
            if let json = try? JSONSerialization.data(withJSONObject: dict, options: []) {
                if let content = String(data: json, encoding: String.Encoding.utf8) {
                    socket.write(string: content)
                }
            }
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("socket disconnected")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        self.navigationItem.title = "Ticker data received...\(tickerCount)"
        self.tickerCount = self.tickerCount+1
        print("Receiveed Ticker data: \(text)")
//        let data = json.data(using: .utf8)!
//        guard let data = data else { return }
//        //Implement JSON decoding and parsing
//        do {
//            //Decode retrived data with JSONDecoder and assing type of Article object
//            self.socketModel = try JSONDecoder().decode(SocketModel.self, from: data)
//            print(self.socketModel.message.info)
//            DispatchQueue.main.async {
//
//            }

    }

    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        // Noop - Must implement since it's not optional in the protocol
    }
    
}





