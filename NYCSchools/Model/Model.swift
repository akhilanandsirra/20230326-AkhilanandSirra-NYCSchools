//
//  Model.swift
//  NYCSchools
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import Foundation

struct SchoolData: Decodable {
    let status: String
    let schools: [Schools]
}

struct Schools : Decodable {
    var dbn: String
    var school_name: String
    var neighborhood: String
    var location: String
    var phone_number: String
    var school_email: String?
    var website: String
    var total_students: String
    var num_of_sat_test_takers: String?
    var sat_math_avg_score: String?
    var sat_critical_reading_avg_score: String?
    var sat_writing_avg_score: String?
}
