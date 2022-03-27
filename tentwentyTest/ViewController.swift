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
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Initial commit")
        setupUIForTabBar()
        
        // Do any additional setup after loading the view.
    }
    func setupUIForTabBar()
    { self.viewForTab.layer.cornerRadius = 27 }
    func setupHeader() {
        
    }

    @IBAction func magnifierTapped(_ sender: Any) {
    
        guard let watchMovie = self.storyboard?.instantiateViewController(withIdentifier: "MovieGenreViewController") as? MovieGenreViewController else { return }
        contentView.addSubview(watchMovie.view)
        watchMovie.didMove(toParent: self)
        self.addChild(watchMovie)
        
    }
    
}
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  Bundle.main.loadNibNamed("MoviesTableViewCell", owner: self, options: nil)?.first as! MoviesTableViewCell
        return cell
    }
    
    
}
