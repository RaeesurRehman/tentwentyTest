//
//  MoviesListViewModel.swift
//  tentwentyTest
//
//  Created by admin on 28/03/2022.
//

import Foundation
import Alamofire
class MoviesListViewModel {
    func loadUpcomingMovies(complition: @escaping  (_ success:Bool,_ message:String,_ resultedArray:[Movie]?) -> Void)  {
        Requests.getUpcomingMovies{ success,message,movies   in
            if success == true
            {
                complition(true,"Success", movies)
            }
            else
            {
                complition(false,"No Movies", nil)
            }
        }
        }
    func loadMovieDetail(id:Int,complition: @escaping  (_ success:Bool,_ message:String,_ resultedMoview:MovieDetail?) -> Void)
    {
        Requests.getMovieDetail(id: id) { success, message, resultedMovie in
            if success == true
            {
                complition(true,"Success", resultedMovie)
            }
            else
            {
                complition(false,"No Movies", nil)
            }
        }
    }
}

