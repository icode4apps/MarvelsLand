//
//  MarvelsListTableViewCell.swift
//  MarvelsLand
//
//  Created by Joao Batista Rocha Jr. on 21/04/16.
//  Copyright © 2016 Joao Batista Rocha Jr. All rights reserved.
//

import UIKit
import Foundation

class MarvelsListTableViewCell: UITableViewCell {
    
    @IBOutlet var marvelName: UILabel!
    @IBOutlet var nextPageButton: UIButton!
    @IBOutlet var nameBack: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
