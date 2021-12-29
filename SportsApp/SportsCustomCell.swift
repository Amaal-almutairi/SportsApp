//
//  SportsCustomCell.swift
//  SportsApp
//
//  Created by Amaal almutairi on 29/12/2021.
//

import UIKit

class SportsCustomCell: UITableViewCell {

    @IBOutlet weak var imagebutton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    
    @IBOutlet weak var listSportslabel: UILabel!
    
}
class PlyerCustomCell:UITableViewCell{
    
    @IBOutlet weak var namelabel: UILabel!
    
    @IBOutlet weak var agelabel: UILabel!
    
    @IBOutlet weak var hightlabel: UILabel!
    
}
