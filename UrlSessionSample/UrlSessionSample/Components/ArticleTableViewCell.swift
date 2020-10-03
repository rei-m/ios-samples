//
//  ArticleTableViewCell.swift
//  UrlSessionSample
//
//  Created by Rei Matsushita on 2020/10/02.
//  Copyright © 2020 Rei Matsushita. All rights reserved.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {

    // MARK: - Properties
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
