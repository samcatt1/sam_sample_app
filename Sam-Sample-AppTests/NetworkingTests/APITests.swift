//
//  APITests.swift
//  Sam-Sample-AppTests
//
//  Created by Samantha Cattani on 2023-09-22.
//

@testable import Sam_Sample_App
import XCTest

final class APITests: XCTestCase {
    var api: API?
    
    override func setUpWithError() throws {
        api = API()
    }

    override func tearDownWithError() throws {
        api = nil
    }

    func testGetDataFromPlist() throws {
        guard let api = api else {
            XCTFail("API cannot be initialized")
            return
        }
        
        let val = api.getDataFromInfoPlist(fieldName: "TestRapidAPIKey")
        
        XCTAssertEqual("test-key", val)
    }
    
    func testGetDataFromPlistBadKey() throws {
        guard let api = api else {
            XCTFail("API cannot be initialized")
            return
        }
        
        let val = api.getDataFromInfoPlist(fieldName: "nonExistantKey")
        
        XCTAssertNil(val)
    }
    
    func testSetUpRequestUrl() throws {
        guard let api = api else {
            XCTFail("API cannot be initialized")
            return
        }

        let request = api.setUpRequest(url: "https://www.google.com")
        
        let headers = [
            "X-RapidAPI-Key": api.getDataFromInfoPlist(fieldName: "RapidAPIKey")!,
            "X-RapidAPI-Host": api.getDataFromInfoPlist(fieldName: "RapidAPIHost")!
        ]

        XCTAssertTrue(request?.httpMethod == "GET")
        XCTAssertEqual(request?.allHTTPHeaderFields?["X-RapidAPI-Host"], headers["X-RapidAPI-Host"])
        XCTAssertEqual(request?.allHTTPHeaderFields?["X-RapidAPI-Key"], headers["X-RapidAPI-Key"])
        XCTAssertTrue(request?.url?.absoluteString == "https://www.google.com")
    }
    
    func testSetUpRequestUrlBadURL() throws {
        guard let api = api else {
            XCTFail("API cannot be initialized")
            return
        }

        let request = api.setUpRequest(url: "™")

        XCTAssertNil(request)
    }
}
