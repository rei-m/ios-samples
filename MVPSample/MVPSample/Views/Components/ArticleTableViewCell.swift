//
//  ArticleTableViewCell.swift
//  MVPSample
//
//  Created by Rei Matsushita on 2020/10/28.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
