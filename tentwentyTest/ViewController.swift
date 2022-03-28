//
//  ViewController.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var viewForTab: UIView!
    let viewModel = MoviesListViewModel()
    @IBOutlet weak var moviesTableView: UITableView!
    var upcomingMovies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Initial commit")
        setupUIForTabBar()
        loadUpcomingMovies()
        
        // Do any additional setup after loading the view.
    }
    func loadUpcomingMovies() {
        self.viewModel.loadUpcomingMovies { success, message, resultedArray in
            if success == true
            {
                if resultedArray != nil {
                    self.upcomingMovies = resultedArray!
                    self.moviesTableView.reloadData()
                    
                }

            }
            else
            {
                CommonClass.sharedInstance.showToast(message: message, vc: self)
            }
        }
    }

    func setupUIForTabBar()
    { self.viewForTab.layer.cornerRadius = 27 }
    func setupHeader() {
        
    }

    @IBAction func magnifierTapped(_ sender: Any) {
    
        guard let watchMovie = self.storyboard?.instantiateViewController(withIdentifier: "MovieGenreViewController") as? MovieGenreViewController else { return }
        watchMovie.upcomingMovies = upcomingMovies
        contentView.addSubview(watchMovie.view)
        watchMovie.didMove(toParent: self)
        self.addChild(watchMovie)
        
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("MoviesTableViewCell", owner: self, options: nil)?.first as! MoviesTableViewCell
        cell.configure(movie: upcomingMovies[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = upcomingMovies[indexPath.row]
        let movieDetail = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetail.modalPresentationStyle = .fullScreen
        movieDetail.selectedMovie = selectedMovie
        self.present(movieDetail, animated: true, completion: nil)
    }
    
    
}
