//
//  Model.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation

struct Detail : Decodable {
    var response : Response
}

struct Response : Decodable {
    var docs : [Doc]
}

struct Doc : Decodable {
    var id : String
    var eissn : String
    var publication_date : String
    var article_type : String
}
