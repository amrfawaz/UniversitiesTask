//
//  NetworkManagerTests.swift
//  
//
//  Created by AmrFawaz on 02/05/2024.
//

import XCTest
import NetworkManager

final class NetworkManagerTests: XCTestCase {
    
    func testFetchDataSuccess() {
        let expectation = XCTestExpectation(description: "Fetch data successfully")
        let url = URL(string: "https://api.example.com/data")!
        
        NetworkManager.shared.fetchData(from: url) { (result: Result<String, NetworkError>) in
            switch result {
            case .success(let data):
                XCTAssertEqual(data, "Some data")
                expectation.fulfill()
            case .failure:
                XCTFail("Fetching data failed")
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFetchDataFailure() {
        let expectation = XCTestExpectation(description: "Fetch data failed")
        let url = URL(string: "https://api.example.com/invalid-url")!
        
        NetworkManager.shared.fetchData(from: url) { (result: Result<String, NetworkError>) in
            switch result {
            case .success:
                XCTFail("Fetching data should fail")
            case .failure(let error):
                XCTAssertEqual(error, .noData)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 5.0)
    }
}

