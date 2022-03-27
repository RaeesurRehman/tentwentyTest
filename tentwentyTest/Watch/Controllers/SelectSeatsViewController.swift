//
//  SelectSeatsViewController.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class SelectSeatsViewController: UIViewController {

    @IBOutlet weak var datesCollectionView: UICollectionView!
    @IBOutlet weak var cinemasCollectionView: UICollectionView!
    var selectedDate = -1
    var selectedSeatLayout = -1
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibcell = UINib(nibName: "DatesCollectionViewCell", bundle: nil)
        datesCollectionView.register(nibcell, forCellWithReuseIdentifier: "DateCell")
        datesCollectionView.reloadData()
        let seatNibcell = UINib(nibName: "SeatLayoutCollectionViewCell", bundle: nil)
        cinemasCollectionView.register(seatNibcell, forCellWithReuseIdentifier: "SeatCell")
        cinemasCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SelectSeatsViewController: UICollectionViewDelegate,UICollectionViewDataSource
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == datesCollectionView {
            return 10
            
        }
        else {
            return 10
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == self.datesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateCell", for: indexPath) as! DatesCollectionViewCell
            if selectedDate != -1 && selectedDate == indexPath.row {
                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.3803921569, green: 0.7647058824, blue: 0.9490196078, alpha: 1)
                cell.dateLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
            else {
                cell.dateLbl.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6509803922, blue: 0.6509803922, alpha: 0.1)
                cell.dateLbl.textColor = #colorLiteral(red: 0.1254901961, green: 0.1725490196, blue: 0.262745098, alpha: 1)
            }
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SeatCell", for: indexPath) as! SeatLayoutCollectionViewCell
            if selectedSeatLayout != -1 && selectedSeatLayout == indexPath.row {
                cell.seatView.layer.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7647058824, blue: 0.9490196078, alpha: 1)
            }
            else {
                cell.seatView.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
            }
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.datesCollectionView {
            selectedDate = indexPath.row
            self.datesCollectionView.reloadData()
        }
        else {
            selectedSeatLayout = indexPath.row
            self.cinemasCollectionView.reloadData()
        }
        
    }
    
    
}
