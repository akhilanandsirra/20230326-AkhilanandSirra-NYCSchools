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
    var total_students: String
    var num_of_sat_test_takers: String?
    var sat_math_avg_score: String?
    var sat_critical_reading_avg_score: String?
    var sat_writing_avg_score: String?
//    var phoneNumber: String
//    var schoolEmail: String
//    var website: String
//    var totalStudents: String
//    var numOfSatTestTakers: String?
//    var satCriticalReadingAvgScore: String?
//    var satMathAvgScore: String?
//    var satWritingAvgScore: String?
    
//    private enum CodingKeys: String, CodingKey {
//        case dbn
//        case schoolName = "school_name"
//        case neighborhood
//        case location
//        case phoneNumber = "phone_number"
//        case schoolEmail = "school_email"
//        case website
//        case totalStudents = "total_students"
//        case numOfSatTestTakers = "num_of_sat_test_takers"
//        case satCriticalReadingAvgScore = "sat_critical_reading_avg_score"
//        case satMathAvgScore = "sat_math_avg_score"
//        case satWritingAvgScore = "sat_writing_avg_score"
//    }
}
