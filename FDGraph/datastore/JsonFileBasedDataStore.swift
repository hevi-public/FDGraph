//
//  JsonFileBasedDataStore.swift
//  FDGraph
//
//  Created by Hevi on 05/01/2021.
//  Copyright © 2021 Hevi. All rights reserved.
//

import Foundation

class JsonFileBasedDataStore: DataStore {
    
    private let storeFileName: String = "FDGraphData"
    
    private var fileCache: [NodeJsonRepresentation] = []
    
    func fetchAll() -> [Node] {
        fatalError("fetchAll not implemented")
    }
    
    func fetch(node: Node?) -> Node? {
        fatalError("fetch not implemented")
    }
    
    func fetchWith(parent: Node?) -> [Node] {
        fatalError("fetchWith not implemented")
    }
    
    func add(node: Node) {
        let jsonRepresentation = NodeJsonRepresentation(text: node.text)
        
        do {
            fileCache.append(jsonRepresentation)
//            let data = try JSONEncoder().encode(jsonRepresentation)
//            let jsonString = String(data: data, encoding: .utf8)!
            try JSONSerialization.save(jsonObject: fileCache, toFilename: storeFileName)
        } catch {
            print("error adding node to Json, TODO proper error handling")
        }
    }
    
    func save(text: String, parent: Node?, nodeAbove: Node?) {
        fatalError("save not implemented")
    }
    
    func update(node: Node) {
        fatalError("update not implemented")
    }
    
    
}

struct NodeJsonRepresentation: Codable {
    let text: String
}

extension JSONSerialization {
    
    static func loadJSON(withFilename filename: String) throws -> Any? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
            return jsonObject
        }
        return nil
    }
    
    static func save(jsonObject: [NodeJsonRepresentation], toFilename filename: String) throws -> Bool {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            
            let jsonData = try encoder.encode(jsonObject)
            try jsonData.write(to: fileURL, options: [.atomicWrite])
            
            return true
        }
        
        return false
    }
}
