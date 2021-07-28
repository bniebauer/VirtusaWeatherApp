//
//  VirtusaWeatherAppTests.swift
//  VirtusaWeatherAppTests
//
//  Created by Brenton Niebauer on 7/27/21.
//

import XCTest
@testable import VirtusaWeatherApp

class VirtusaWeatherAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testValidZipCode() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let validZipCode = "16066"
        WeatherController.shared.fetchWeatherFor(zip: validZipCode) { result in
            switch result {
            case .success(let weather):
                XCTAssert(weather.location!.name == "Cranberry Township")
            case .failure( _):
                XCTFail()
            }
            
        }
    }
    
    func testInvalidZipCode() throws {
        let invalidZip = "abcd"
        WeatherController.shared.fetchWeatherFor(zip: invalidZip) { result in
            switch result {
            case .success( _):
                XCTFail()
            case .failure(let error):
                print(error.localizedDescription)
                XCTAssert(true)
            }
        }
    }

}
