//
//  MovieDetailModel.swift
//  tentwentyTest
//
//  Created by admin on 29/03/2022.
//

import Foundation
import ObjectMapper
final class MovieDetail: Mappable,Encodable,Decodable
{
    var adult : Bool?
    var backdrop_path : String?
    var budget: Int?
    var genre_ids = [Genre]()
    var id : Int?
    var imdb_id: String?
    var original_language : String?
    var original_title : String?
    var overview : String?
    var popularity : Int?
    var poster_path : String?
    var release_date : String?
    var revenue : Int?
    var status : String?
    var tagline : String?
    var title : String?
    var video  : Bool?
    var vote_average : Int?
    var vote_count : Int?
    init?(map: Map) {
         mapping(map: map)
    }
    init() {
        
    }
    func mapping(map: Map) {
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        budget <- map["budget"]
        genre_ids <- map["genres"]
        id <- map["id"]
        imdb_id <- map["imdb_id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        revenue <- map["revenue"]
        status <- map["status"]
        tagline <- map["tagline"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }
    
    
}
