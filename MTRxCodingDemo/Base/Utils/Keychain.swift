//
//  Keychain.swift
//  MTRxCodingDemo
//
//  Created by 吴迪玮 on 2020/8/4.
//  Copyright © 2020 DNT. All rights reserved.
//

import KeychainSwift

public struct Credential {
    
    public let key: Key
    public let value: String
    
    public struct Key {
        let keyName: String
        
        public static var token: Key {
            return Key(keyName: "token")
        }
        
        public static var uuid: Key {
            return Key(keyName: "uuid")
        }
        
        public init(keyName: String) {
            self.keyName = keyName
        }
    }
    
    public static func token(_ value: String) -> Credential {
        return Credential(key: .token, value: value)
    }
    
    public static func uuid(_ value: String) -> Credential {
        return Credential(key: .uuid, value: value)
    }
    
    public init(key: Key, value: String) {
        self.key = key
        self.value = value
    }
}

public final class Keychain {
    private static let keychain = KeychainSwift()
    
    public static func save(credentials: [Credential]) {
        credentials.forEach { keychain.set($0.value, forKey: $0.key.keyName) }
    }
    
    public static func delete(_ keys: [Credential.Key]) {
        keys.forEach { keychain.delete($0.keyName) }
    }
    
    public static func get(_ key: Credential.Key) -> Credential? {
        return keychain.get(key.keyName).map { Credential(key: key, value: $0) }
    }
    
    public static func has(_ key: Credential.Key) -> Bool {
        return keychain.get(key.keyName) != nil
    }
}
