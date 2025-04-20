//
//  ListTableViewCell.swift
//  CountriesApp
//
//   Created by  Neha Bisht on 04/02/25.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var capitalNameLabelCell: UILabel!
    @IBOutlet weak var codeLabelCell: UILabel!
    @IBOutlet weak var regionNameLabelCell: UILabel!
    @IBOutlet weak var countryNameLabelCell: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
