//
//  DatesCollectionViewCell.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class DatesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var dateLbl: PaddingLabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI() {
        self.dateLbl.layer.cornerRadius = 10
        self.dateLbl.layer.masksToBounds = true
    }
}
