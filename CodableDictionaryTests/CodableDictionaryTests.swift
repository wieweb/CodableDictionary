//
//  CodableDictionaryTests.swift
//  CodableDictionaryTests
//
//  Created by Stefan Wieland on 28.10.17.
//  Copyright © 2017 WielandWeb  - Stefan Wieland. All rights reserved.
//

import XCTest
@testable import CodableDictionary

class CodableDictionaryTests: XCTestCase {
    
    private let mockData: Data = {
        let bundle = Bundle(for: CodableDictionaryTests.self)
        let url = bundle.url(forResource: "test", withExtension: "json")!
        return try! Data(contentsOf: url)
    }()

    func testDecodeString() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let stringValue = model!["user1"] as? String
        XCTAssertNotNil(stringValue, "stringValue should not return nil")
        XCTAssertEqual(stringValue, "Stefan")
    }
    
    func testDecodeInt() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let intValue = model!["int"] as? Int
        XCTAssertNotNil(intValue, "intValue should not return nil")
        XCTAssertEqual(intValue, 0)
    }
    
    func testDecodeDouble() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let doubleValue = model!["double"] as? Double
        XCTAssertNotNil(doubleValue, "doubleValue should not return nil")
        XCTAssertEqual(doubleValue, 13.506)
    }
    
    func testDecodeBool() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let boolValue = model!["bool"] as? Bool
        XCTAssertNotNil(boolValue, "boolValue should not return nil")
        XCTAssertEqual(boolValue, true)
    }
    
    func testDecodeArrayOfString() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let stringArrayValue = model!["aString"] as? [String]
        XCTAssertNotNil(stringArrayValue, "stringArrayValue should not return nil")
        XCTAssertEqual(stringArrayValue!, ["string1", "string2"])
    }
    
    func testDecodeArrayOfBool() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let boolArrayValue = model!["aBool"] as? [Bool]
        XCTAssertNotNil(boolArrayValue, "boolArrayValue should not return nil")
        XCTAssertEqual(boolArrayValue!, [true, false])
    }
    
    func testDecodeArrayOfInt() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let intArrayValue = model!["aInt"] as? [Int]
        XCTAssertNotNil(intArrayValue, "intArrayValue should not return nil")
        XCTAssertEqual(intArrayValue!, [0, 1, 2])
    }
    
    func testDecodeArrayOfDouble() {
        let model = try? JSONDecoder().decode(CodableDictionary.self, from: mockData)
        XCTAssertNotNil(model, "model should not return nil, decoding failed")
        let doubleArrayValue = model!["aDouble"] as? [Double]
        XCTAssertNotNil(doubleArrayValue, "doubleArrayValue should not return nil")
        XCTAssertEqual(doubleArrayValue!, [0.1, 1.2])
    }
    
}
