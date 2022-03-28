//
//  Movie.swift
//  tentwentyTest
//
//  Created by admin on 28/03/2022.
//

import Foundation
import ObjectMapper
final class Movie: Mappable,Encodable,Decodable
{
    var adult : Bool?
    var backdrop_path : String?    
    var genre_ids : [Int]?
    var id : Int?
    var original_language: String?
    var original_title : String?
    var overview : String?
    var popularity : Int?
    var poster_path : String?
    var release_date : String?
    var title : String?
    var video  : Bool?
    var vote_average : Int?
    var vote_count : Int?
    init?(map: Map) {
         mapping(map: map)
    }
    init() {
        
    }
//    init(name: String,lastName: String,email:String,password: String,phone:String) {
//        self.name = name
//        self.lastname = lastName
//        self.email = email
//        self.password = password
//        self.phone = phone
//    }
    
    func mapping(map: Map) {
        adult <- map["adult"]
        backdrop_path <- map["backdrop_path"]
        genre_ids <- map["genre_ids"]
        id <- map["id"]
        original_language <- map["original_language"]
        original_title <- map["original_title"]
        overview <- map["overview"]
        popularity <- map["popularity"]
        poster_path <- map["poster_path"]
        release_date <- map["release_date"]
        title <- map["title"]
        video <- map["video"]
        vote_average <- map["vote_average"]
        vote_count <- map["vote_count"]
    }
    
    
}

