//
//  ITLCoursesTableViewCell.swift
//  JsonDemo
//
//  Created by Lubos Ilcik on 08/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit

class ITLCoursesTableViewCell: UITableViewCell {

    @IBOutlet weak var courseImageView: UIImageView!
    @IBOutlet weak var courseTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
