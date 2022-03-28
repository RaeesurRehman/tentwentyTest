//
//  MoviesTableViewCell.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class MoviesTableViewCell: UITableViewCell {

    @IBOutlet weak var movieThumbnail: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(movie: Movie){
        self.movieTitle.text = movie.title ?? ""
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
