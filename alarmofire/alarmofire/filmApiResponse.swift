//
//  filmApiResponse.swift
//  alarmofire
//
//  Created by Abdullah Mohammed on 26/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import Foundation
import ObjectMapper

class StarWarApi:Mappable {
    
    var starWar : [FilmTitle]?  // arry
    var count: Int?
    
    required init?(map:Map) {
        
    }
    func mapping(map:Map){
        count <- map["count"]
        starWar <- map["results"]
    }
    
}


class FilmTitle:Mappable {
    
    var title : String?
    var episode_id : Int?
    
    required init(map:Map) {
        
    }
    
    func mapping(map:Map){
        title <- map["title"]
        episode_id <- map["episode_id"]
        
    }
    
}
