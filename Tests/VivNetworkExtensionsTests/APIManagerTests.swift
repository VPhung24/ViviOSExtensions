//
//  APIManagerTests.swift
//  VivNetworkExtensionsTests
//
//  Created by Vivian Phung on 2/23/23.
//

import XCTest
@testable import VivNetworkExtensions

final class APIManagerTests: XCTestCase {
    let manager = APIManagerImpl()

    func testDecoding() {
        let expectation = self.expectation(description: "decoding one object")

        // Create data and tell the session to always return it
        let coffeeShop = CoffeeShopModel(name: "Blue Bottle")

        let urlRequest = manager.networkRequest(baseURL: "https://viv.paste.lol/", endpoint: NetworkTestEndpoints.oneCofeeShop)

        var oneshop: Result<CoffeeShopModel, Error>?

        manager.networkTask(request: urlRequest) { (result: Result<CoffeeShopModel, Error>) in
            oneshop = result

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

        switch oneshop {
        case .success(let success):
            XCTAssertEqual(success, coffeeShop)
        case .failure(let failure):
            XCTAssertNil(failure)
        default:
            XCTFail("test result should return a failure or success. check expectation")
        }
    }

    func testDecodingArray() {
        let expectation = self.expectation(description: "decoding array")

        // Create data and tell the session to always return it
        let coffeeShop = [CoffeeShopModel(name: "Blue Bottle"), CoffeeShopModel(name: "Starbucks"), CoffeeShopModel(name: "Peets")]

        let urlRequest = manager.networkRequest(baseURL: "https://viv.paste.lol/", endpoint: NetworkTestEndpoints.arrayCoffeeShop)

        var arrayResult: Result<[CoffeeShopModel], Error>?

        manager.networkTask(request: urlRequest) { (result: Result<[CoffeeShopModel], Error>) in
            arrayResult = result

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

        switch arrayResult {
        case .success(let success):
            XCTAssertEqual(success, coffeeShop, "coffee shop array is the same")
        case .failure(let failure):
            XCTAssertNil(failure)
        default:
            XCTFail("test result should return a failure or success. check expectation")
        }
    }

    func testFailedDataDecoding() {
        let expectation = self.expectation(description: "failed decoding")

        let urlRequest = manager.networkRequest(baseURL: "https://viv.paste.lol/", endpoint: NetworkTestEndpoints.arrayCoffeeShop)
        // Perform the request and verify the result
        var testResult: Result<CoffeeShopModel, Error>?

        manager.networkTask(request: urlRequest) { (result: Result<CoffeeShopModel, Error>) in
            testResult = result

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10, handler: nil)

        switch testResult {
        case .success(let success):
            XCTAssertNil(success, "error ===> incorrect data model. should fail")
        case .failure(let failure):
            XCTAssertNotNil(failure, "error ===> incorrect data model. failure should not be nil.")
        case .none:
            XCTFail("test result should return a failure or success. check expectation")
        }
    }

}

enum NetworkTestEndpoints: Endpoint {
    case oneCofeeShop, arrayCoffeeShop

    var path: String {
        switch self {
        case .oneCofeeShop:
            return "apimanagertestcoffeemodel/raw"
        case .arrayCoffeeShop:
            return "apimanagertestcoffeemodelarrray/raw"
        }
    }

    var method: VivNetworkExtensions.Method {
        return .GET
    }
}
