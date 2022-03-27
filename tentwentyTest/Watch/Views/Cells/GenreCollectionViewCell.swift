//
//  GenreCollectionViewCell.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class GenreCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var genreNameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        
    }
    func setupUI() {
        self.genreNameLbl.layer.cornerRadius = 10
        self.genreNameLbl.layer.masksToBounds = true
    }
}
