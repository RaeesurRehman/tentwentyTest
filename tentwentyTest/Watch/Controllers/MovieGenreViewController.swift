//
//  MovieGenreViewController.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class MovieGenreViewController: UIViewController {

    @IBOutlet weak var genreCollectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var movieListView: UIView!
    @IBOutlet weak var searchTF: UITextField!
    @IBOutlet weak var moviesTableView: UITableView!
    @IBOutlet var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nibcell = UINib(nibName: "MovieGenreCollectionViewCell", bundle: nil)
        genreCollectionView.register(nibcell, forCellWithReuseIdentifier: "GenreCell")
        genreCollectionView.reloadData()
        searchView.layer.cornerRadius = searchView.frame.height / 2
        self.searchTF.returnKeyType = .go
        // Do any additional setup after loading the view.
    }
    func activeMoviesView(_ active:Bool) {
        if active {
            self.genreCollectionView.isHidden = true
            self.movieListView.isHidden = false
            self.moviesTableView.reloadData()
        }
        else
        {
            self.movieListView.isHidden = true
            self.genreCollectionView.isHidden = false
            self.genreCollectionView.reloadData()
        }
    }
    @IBAction func closeTapped(_ sender: Any) {
        if searchTF.isFirstResponder {
            searchTF.text = ""
            searchTF.resignFirstResponder()
            activeMoviesView(false)
        }
        else {
        self.view.removeFromSuperview()
        }
    }
    
}
extension MovieGenreViewController : UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GenreCell", for: indexPath) as! MovieGenreCollectionViewCell
        return cell
    }
    
    
}
extension MovieGenreViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("MovieTableViewCell", owner: self, options: nil)?.first as! MovieTableViewCell
        return cell
    }
    
    
}
extension MovieGenreViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("text field on")
        activeMoviesView(true)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return tapped")
        self.contentView.isHidden = false
        searchTF.resignFirstResponder()
        guard let searchResultView = self.storyboard?.instantiateViewController(withIdentifier: "SearchResultViewController") as? SearchResultViewController else { return true }
        contentView.addSubview(searchResultView.view)
        searchResultView.didMove(toParent: self)
        self.addChild(searchResultView)
        return true
    }
}
