//
//  EUkiUserDefaults.swift
//  Euki
//
//  Created by Víctor Chávez on 10/08/22.
//  Copyright © 2022 Ibis. All rights reserved.
//

import Foundation
import SwiftyJSON
import CryptoSwift

class EUkiUserDefaults {
    static let sharedInstance = EUkiUserDefaults()
    
    private let fileName = "euki.data"
    private let encryptionKey = "d41f04c846d944f1"
    
    private var dict = [String: Any]()
    
    private init() {
        if self.checkFile() {
            self.readFile()
        } else {
            self.writeFile()
        }
    }
    
    // MARK: - Private
    
    private func checkFile() -> Bool {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        
        guard let pathComponent = url.appendingPathComponent(fileName) else {
            print("Can't append component to path")
            return false
        }
        
        let filePath = pathComponent.path
        let fileManager = FileManager.default
        return fileManager.fileExists(atPath: filePath)
    }
    
    private func readFile() {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Can't read documentDirectory")
            return
        }
        let fileUrl = dir.appendingPathComponent(fileName)
        
        do {
            let text = try String(contentsOf: fileUrl, encoding: .utf8)
            if let decrypted = self.decrypt(text: text) {
                self.proccessDict(text: decrypted)
            } else {
                print("Can't decrypt file")
            }
        } catch {
            print("Can't read File")
        }
    }
    
    private func proccessDict(text: String) {
        if let dict = JSON.init(parseJSON: text).dictionaryObject {
            self.dict = dict
        } else {
            print("Cannot convert JSON to Dict")
        }
    }
    
    private func writeFile() {
        if let json = JSON(dict).rawString() {
            if let string = encrypt(text: json) {
                self.saveFile(text: string)
            } else {
                print("Cannot encrypt JSON")
            }
        } else {
            print("Cannot convert dict to JSON")
        }
    }
    
    private func saveFile(text: String) {
        guard let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            print("Can't read documentDirectory")
            return
        }
        var fileUrl = dir.appendingPathComponent(fileName)
        
        do {
            try text.write(to: fileUrl, atomically: false, encoding: .utf8)
            
            var res = URLResourceValues()
            res.isExcludedFromBackup = true
            try fileUrl.setResourceValues(res)
        } catch {
            print("Can't write content to file")
        }
    }
    
    private func decrypt(text: String) -> String? {
        if let aes = try? AES(key: encryptionKey.bytes, blockMode: ECB()),
           let decrypted = try? aes.decrypt(Array(base64: text)),
           let string = String(bytes: decrypted, encoding: .utf8) {
            return string
        }
        return nil
    }
    
    private func encrypt(text: String) -> String? {
        if let aes = try? AES(key: encryptionKey.bytes, blockMode: ECB()),
           let encrypted = try? aes.encrypt(Array(text.utf8)).toBase64() {
            return encrypted
        }
        return nil
    }
    
    // MARK: - Public
    
    func set(_ value: Any?, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func set(_ value: [Any]?, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func set(_ value: String, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func set(_ value: Int, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func set(_ value: Bool, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func set(_ value: Date, forKey defaultName: String) {
        self.dict[defaultName] = value
    }
    
    func object(forKey defaultName: String) -> Any? {
        return self.dict[defaultName]
    }
    
    func string(forKey defaultName: String) -> String? {
        return self.dict[defaultName] as? String
    }
    
    func integer(forKey defaultName: String) -> Int {
        return (self.dict[defaultName] as? Int) ?? 0
    }
    
    func bool(forKey defaultName: String, defaultValue: Bool = false) -> Bool {
        return (self.dict[defaultName] as? Bool) ?? defaultValue
    }
    
    func array(forKey defaultName: String) -> [Any]? {
        return self.dict[defaultName] as? [Any]
    }
    
    func synchronize() {
        self.writeFile()
    }
}
