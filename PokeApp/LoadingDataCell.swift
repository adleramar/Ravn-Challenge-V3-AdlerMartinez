//
//  LoadingDataCell.swift
//  PokeApp
//
//  Created by Adler on 7/12/22.
//

import UIKit

class LoadingDataCell: UITableViewCell {

    @IBOutlet weak var loadingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isUserInteractionEnabled = false
        loadingLabel.text = "Loading..."
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionStyle = .none
    }
    
}
