//
//  coinListTableViewCell.swift
//  KoinEx
//
//  Created by Satish Mavani on 03/12/18.
//  Copyright © 2018 com.KoinEx.com. All rights reserved.
//

import UIKit

class coinListTableViewCell: UITableViewCell {

    @IBOutlet weak var lblLatestPrice: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var coinName: UILabel!
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var percentChange: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
