//
//  CarTableViewCell.swift
//  BorusanAutoHack
//
//  Created by Mac on 13.12.2023.
//

import UIKit

class CarTableViewCell: UITableViewCell {

    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var roadLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
