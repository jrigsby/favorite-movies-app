//
//  CustomTableViewCell.swift
//  favorite-movies-app
//
//  Created by John Rigsby on 11/29/18.
//  Copyright © 2018 TCR Development, LLC. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet var movieImageView: UIImageView!
    @IBOutlet var movieTitle: UILabel!
    @IBOutlet var movieYear: UILabel!
    @IBOutlet var favButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
