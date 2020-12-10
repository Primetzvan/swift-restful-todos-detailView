//
//  TableViewCell.swift
//  RestDownload
//
//  Created by Vanessa Primetzhofer on 19.11.20.
//  Copyright © 2020 Vanessa Primetzhofer. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    var userId = 0
    var todo : ToDo?
    @IBOutlet weak var button: UIButton!
    
    @IBAction func onClick(_ sender: UIButton){
       print(self.textLabel?.text)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //print("hallo")
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
