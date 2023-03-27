//
//  NYCSchoolsTests.swift
//  NYCSchoolsTests
//
//  Created by Akhil Anand Sirra on 23/03/23.
//

import XCTest
@testable import NYCSchools

final class NYCSchoolsTests: XCTestCase {
    // SUT --> System Under Test
    func testSearchResults() {
        let sut = getData()
        sut.data = [Schools(dbn: "01M292", school_name: "School A", neighborhood: "Test Neighborhood", location: "220 Henry Street, New York NY 10002", phone_number: "212-406-9411", website: "http://www.henrystreet.org", total_students: "323"), Schools(dbn: "01M292", school_name: "School B", neighborhood: "Test Neighborhood", location: "220 Henry Street, New York NY 10002", phone_number: "212-406-9411", website: "http://www.henrystreet.org", total_students: "323")]
        sut.searchText = "A"
        XCTAssertEqual(sut.searchResults.count, 1)
    }
    
    func testGetTrimmedAddress() {
        let sut = getData()
        let addressString = "123 Main Street (40.7128, -74.0060)"
        let trimmedAddress = sut.getTrimmedAddress(from: addressString)
        XCTAssertEqual(trimmedAddress, "123 Main Street")
    }
    
    func testMakePhoneCall() {
        let sut = getData()
        let phoneNumber = "555-555-1212"
        sut.makePhoneCall(phoneNumber: phoneNumber)
        // Manually verify that the phone app opens with the correct number
    }
    
    func testSendEmail() {
        let sut = getData()
        let emailAddress = "test@example.com"
        sut.sendEmail(to: emailAddress)
        // Manually verify that the email app opens with the correct address
    }
    
    func testIsValidEmailAddress() {
        let sut = getData()
        XCTAssertTrue(sut.isValidEmailAddress("test@example.com"))
        XCTAssertFalse(sut.isValidEmailAddress("test@"))
        XCTAssertFalse(sut.isValidEmailAddress("test"))
    }
}
