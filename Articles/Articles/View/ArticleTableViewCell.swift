//
//  ArticleTableViewCell.swift
//  Articles
//
//  Created by Tauqeer Ahmed Khan on 25/11/21.
//

import UIKit

/** Custom Cell class that is loaded on the the TableView along with the labels in the ArticleViewController */

class ArticleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var byLineLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
