//
//  SeatLayoutCollectionViewCell.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class SeatLayoutCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var seatView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    func setupUI() {
        self.seatView.layer.cornerRadius = 10
        self.seatView.layer.borderWidth = 1
        self.seatView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
}
