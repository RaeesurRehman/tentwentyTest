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
    @IBOutlet weak var movieCoverPhoto: UIImageView!
    @IBOutlet weak var overViewText: UITextView!
    @IBOutlet weak var inTheaterLabel: UILabel!
    var selectedMovie = Movie()
    let viewModel = MoviesListViewModel()
    var movieGenres = [Genre]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSelectedMovie()
        let nibcell = UINib(nibName: "GenreCollectionViewCell", bundle: nil)
        genreCollectionView.register(nibcell, forCellWithReuseIdentifier: "GenreTypeCell")
        genreCollectionView.reloadData()

        // Do any additional setup after loading the view.
    }
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupUI() {
        self.getTicketsBtn.layer.cornerRadius = 10
        self.watchTrailerBtn.layer.cornerRadius = 10
        self.watchTrailerBtn.layer.borderWidth = 1
        self.watchTrailerBtn.layer.borderColor = #colorLiteral(red: 0.3803921569, green: 0.7647058824, blue: 0.9490196078, alpha: 1)
    }
    func fillData(movie: MovieDetail) {
        self.inTheaterLabel.text = "In theaters \(movie.release_date ?? "") "
        self.overViewText.text = movie.overview
        self.movieGenres = movie.genre_ids
        self.genreCollectionView.reloadData()
    }
    func loadSelectedMovie() {
        self.viewModel.loadMovieDetail(id: selectedMovie.id!) { success, message, resultedMovie in
            if success == true
            {
                self.fillData(movie: resultedMovie!)
            }
            else
            {
                CommonClass.sharedInstance.showToast(message: message, vc: self)
            }
        }
    }


}
extension MovieDetailViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieGenres.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreTypeCell", for: indexPath) as! GenreCollectionViewCell
        cell.genreNameLbl.text = self.movieGenres[indexPath.row].name
        cell.genreNameLbl.backgroundColor = .random
        return cell
    }
    
    
}
