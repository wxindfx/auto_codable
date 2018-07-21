//
//  AutoProtocol.swift
//  AutoCodable
//
//  Created by lucky.li on 2018/6/4.
//  Copyright © 2018 cico. All rights reserved.
//

import Foundation

private let kDefaultJSONDecoder = JSONDecoder()
private let kDefaultJSONEncoder = JSONEncoder()

public protocol CICOAutoCodable: Codable {}

public extension Decodable {
    public init?(jsonData: Data, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONData(Self.self, from: jsonData) {
            self = object
        } else {
            return nil
        }
    }
    
    public init?(jsonString: String, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONString(Self.self, from: jsonString) {
            self = object
        } else {
            return nil
        }
    }
    
    public init?(jsonObject: Any, jsonDecoder: JSONDecoder? = nil) {
        let decoder: JSONDecoder
        if let jsonDecoder = jsonDecoder {
            decoder = jsonDecoder
        } else {
            decoder = kDefaultJSONDecoder
        }
        
        if let object: Self = decoder.decodeJSONObject(Self.self, from: jsonObject) {
            self = object
        } else {
            return nil
        }
    }
}

public extension Encodable {
    public func toJSONData(jsonEncoder: JSONEncoder? = nil) -> Data? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONData(object: self)
    }
    
    public func toJSONString(jsonEncoder: JSONEncoder? = nil) -> String? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONString(object: self)
    }
    
    public func toJSONObject<R>(returnType: R.Type, jsonEncoder: JSONEncoder? = nil) -> R? {
        let encoder: JSONEncoder
        if let jsonEncoder = jsonEncoder {
            encoder = jsonEncoder
        } else {
            encoder = kDefaultJSONEncoder
        }
        
        return encoder.encodeToJSONObject(object: self, returnType: returnType)
    }
    
    public func toJSONDictionary(jsonEncoder: JSONEncoder? = nil) -> Dictionary<AnyHashable, Any>? {
        return self.toJSONObject(returnType: Dictionary<AnyHashable, Any>.self)
    }
    
    public func toJSONArray(jsonEncoder: JSONEncoder? = nil) -> Array<Any>? {
        return self.toJSONObject(returnType: Array<Any>.self)
    }
}

