//
//  MovieListTableViewCell.swift
//  MovieBrowser
//
//  Created by mounika on 5/28/21.
//  Copyright © 2021 Lowe's Home Improvement. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {

    @IBOutlet weak var movie_rating: UILabel!
    @IBOutlet weak var release_date: UILabel!
    @IBOutlet weak var movie_title: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
