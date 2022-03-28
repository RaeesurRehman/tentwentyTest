//
//  File.swift
//  tentwentyTest
//
//  Created by admin on 29/03/2022.
//

import Foundation
import ObjectMapper
final class Genre:  Mappable,Encodable,Decodable {
    var id : Int?
    var name : String?
     init?(map: Map) {
         mapping(map: map)
    }
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
    }
}
