//
//  SearchResultViewController.swift
//  tentwentyTest
//
//  Created by admin on 26/03/2022.
//

import UIKit

class SearchResultViewController: UIViewController {
    @IBOutlet weak var moviesTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    func presentMovieDetialVC() {
        let movieDetail = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
        movieDetail.modalPresentationStyle = .fullScreen
        self.present(movieDetail, animated: true, completion: nil)
    }



}
extension SearchResultViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("MovieTableViewCell", owner: self, options: nil)?.first as! MovieTableViewCell
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presentMovieDetialVC()
    }
    
}
