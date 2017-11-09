//
//  CodableDictionary.swift
//  CodableDictionary
//
//  Created by Stefan Wieland on 28.10.17.
//  Copyright © 2017 WielandWeb  - Stefan Wieland. All rights reserved.
//

import Foundation

public struct CodableDictionary: Codable {
    
    private var value: [String: Any]
    
    public init(value: [String: Any]) {
        self.value = value
    }
    
    public var rawValue: [String: Any] {
        return value
    }
    
    // MARK: - subscripts
    
    public subscript(key: String) -> Any? {
        get {
            return self.value[key]
        }
        set {
            self.value[key] = newValue
        }
    }
    
    // MARK: - Dictionary implementations
    
    public var isEmpty: Bool {
        return value.isEmpty
    }
    
    public var count: Int {
        return value.count
    }
    
    public var capacity: Int {
        return value.capacity
    }
    
    public func index(forKey key: String) -> Dictionary<String, Any>.Index? {
        return value.index(forKey: key)
    }
    
    public var first: (key: String, value: Any)? {
        return value.first
    }
    
    public var keys: Dictionary<String, Any>.Keys {
        return value.keys
    }
    
    public var values: Dictionary<String, Any>.Values {
        return value.values
    }
    
    // MARK: - Codable
    
    public struct DynamicCodingKeys: CodingKey {
        public  var stringValue: String
        public  var intValue: Int?
        
        public  init?(stringValue: String) { self.stringValue = stringValue }
        public  init?(intValue: Int) { self.intValue = intValue; self.stringValue = "\(intValue)" }
        
        init?(key: CodingKey) {
            if let intValue = key.intValue {
                self.init(intValue: intValue)
            } else {
                self.init(stringValue: key.stringValue)
            }
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: DynamicCodingKeys.self)
        
        var dict: [String: Any] = [:]
        
        for key in container.allKeys {
            guard let codingKey = DynamicCodingKeys(key: key) else { continue }
            
            if let string: String = try? container.decode(String.self, forKey: codingKey) {
                dict[key.stringValue] = string
            } else if let bool: Bool = try? container.decode(Bool.self, forKey: codingKey) {
                dict[key.stringValue] = bool
            } else if let int: Int = try? container.decode(Int.self, forKey: codingKey) {
                dict[key.stringValue] = int
            } else if let double: Double = try? container.decode(Double.self, forKey: codingKey) {
                dict[key.stringValue] = double
            } else if let array: [String] = try? container.decode([String].self, forKey: codingKey) {
                dict[key.stringValue] = array
            } else if let array: [Bool] = try? container.decode([Bool].self, forKey: codingKey) {
                dict[key.stringValue] = array
            } else if let array: [Int] = try? container.decode([Int].self, forKey: codingKey) {
                dict[key.stringValue] = array
            } else if let array: [Double] = try? container.decode([Double].self, forKey: codingKey) {
                dict[key.stringValue] = array
            } else if let nestedDict: CodableDictionary = try? container.decode(CodableDictionary.self, forKey: codingKey) {
                dict[key.stringValue] = nestedDict.value
            } else {
                let context = DecodingError.Context(codingPath: [], debugDescription: "Could not find Type of value in key: \(key.stringValue)")
                throw DecodingError.dataCorrupted(context)
            }
        }
        
        self.value = dict
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: DynamicCodingKeys.self)
        
        for (key, value) in value {
            guard let codingKey = DynamicCodingKeys(stringValue: key) else { continue }
            
            switch value {
            case let value as String:
                try container.encode(value, forKey: codingKey)
            case let value as Int:
                try container.encode(value, forKey: codingKey)
            case let value as Double:
                try container.encode(value, forKey: codingKey)
            case let value as Bool:
                try container.encode(value, forKey: codingKey)
            case let value as [String]:
                try container.encode(value, forKey: codingKey)
            case let value as [Int]:
                try container.encode(value, forKey: codingKey)
            case let value as [Double]:
                try container.encode(value, forKey: codingKey)
            case let value as [Bool]:
                try container.encode(value, forKey: codingKey)
            default:
                if let additionalEncoding = self.additionalEncoding {
                    try additionalEncoding(&container, codingKey, value)
                } else {
                    let context = EncodingError.Context(codingPath: [codingKey], debugDescription: "Could not encode value (\(value)) for unknwon type.")
                    throw EncodingError.invalidValue(value, context)
                }
                
            }
        }
    }
    
    public var additionalEncoding: ((_ container: inout KeyedEncodingContainer<CodableDictionary.DynamicCodingKeys>, _ codingKey: CodableDictionary.DynamicCodingKeys, _ value: Any) throws -> Void)?
    
}
