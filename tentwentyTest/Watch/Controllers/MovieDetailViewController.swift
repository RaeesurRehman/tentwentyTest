//
//  MovieDetailViewController.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var watchTrailerBtn: UIButton!
    @IBOutlet weak var getTicketsBtn: UIButton!
    @IBOutlet weak var genreCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let nibcell = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        genreCollectionView.register(nibcell, forCellWithReuseIdentifier: "GenreTypeCell")
        genreCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    func setupUI() {
        self.getTicketsBtn.layer.cornerRadius = 10
        self.watchTrailerBtn.layer.cornerRadius = 10
        self.watchTrailerBtn.layer.borderWidth = 1
        self.watchTrailerBtn.layer.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7647058824, blue: 0.9490196078, alpha: 1)
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
extension MovieDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreTypeCell", for: indexPath) as! GenreCollectionViewCell
        return cell
    }
    
    
}
