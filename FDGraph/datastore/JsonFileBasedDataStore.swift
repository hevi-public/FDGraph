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
        do {
            fileCache = try JSONSerialization.loadJSON(withFilename: storeFileName)
            
            // Convert to Nodes
            let nodes = fileCache.map { nodeJson -> Node in
                Node(id: nodeJson.id,
                     parent: nil,
                     text: nodeJson.text,
                     expanded: nodeJson.expanded,
                     done: nodeJson.done,
                     type: nodeJson.type.nodeType(),
                     fixed: nodeJson.fixed,
                     position: CGPoint(x: nodeJson.posX, y: nodeJson.posY))
            }
            
            // Set parent
            fileCache.forEach { jsonRepr in
                if jsonRepr.parentId != nil {
                    if let parentId = jsonRepr.parentId,
                       let nodeWithId = findNodeWithId(id: jsonRepr.id, nodes: nodes),
                       let nodeWithParentId = findNodeWithId(id: parentId, nodes: nodes) {
                        
                        nodeWithId.parent = nodeWithParentId
                    }
                }
            }
            
            
            return nodes
        } catch {
            print("error fetching all, TODO proper error handling")
        }
        return []
    }
    
    func fetch(node: Node?) -> Node? {
        fatalError("fetch not implemented")
    }
    
    func fetchWith(parent: Node?) -> [Node] {
        fatalError("fetchWith not implemented")
    }
    
    func add(node: Node) {
//        guard let id = node.id else { return }
        
        var nodeType: NodeTypeJsonRepresentation = .text
        
        switch node.type {
        case .text:
            nodeType = .text
        default:
            nodeType = .text
        }
        
        let jsonRepresentation = NodeJsonRepresentation(
            id: node.id ?? 0,
            parentId: node.parent?.id ?? nil,
            text: node.text,
            type: nodeType,
            expanded: node.expanded,
            done: node.done,
            fixed: node.fixed,
            posX: node.nodeParticle.position.x,
            posY: node.nodeParticle.position.y
        )
        
        fileCache.append(jsonRepresentation)
        
        updateFile()
    }
    
    func save(text: String, parent: Node?, nodeAbove: Node?) {
        fatalError("save not implemented")
    }
    
    func update(node: Node) {
        let nodeFromCacheIndex = fileCache.firstIndex(where: { jsonNode -> Bool in
            jsonNode.id == node.id
        })
        
        if let i = nodeFromCacheIndex {
            fileCache[i].parentId = node.parent?.id
            fileCache[i].text = node.text
//            fileCache[i].type = node
            fileCache[i].expanded = node.expanded
            fileCache[i].done = node.done
            fileCache[i].fixed = node.fixed
            fileCache[i].posX = node.nodeParticle.position.x
            fileCache[i].posY = node.nodeParticle.position.y
            
            updateFile()
        }
    }
    
    private func findNodeWithId(id: Int, nodes: [Node]) -> Node? {
        return nodes.first { node -> Bool in
            node.id == id
        }
    }
    
    private func updateFile() {
        do {
            _ = try JSONSerialization.save(jsonObject: fileCache, toFilename: storeFileName)
        } catch {
            print("error adding node to Json, TODO proper error handling")
        }
    }
    
}

struct NodeJsonRepresentation: Codable {
    let id: Int
    var parentId: Int?
    var text: String
    var type: NodeTypeJsonRepresentation
    var expanded: Bool
    var done: Bool
    var fixed: Bool
    
    var posX: CGFloat
    var posY: CGFloat
}

enum NodeTypeJsonRepresentation: String, Codable {
    case text
    case input
    
    func nodeType() -> NodeType {
        switch self {
        case .text:
            return NodeType.text
        case .input:
            return NodeType.input
        default:
            fatalError("Node without type cannot be converted")
        }
    }
}

extension JSONSerialization {
    
    static func loadJSON(withFilename filename: String) throws -> [NodeJsonRepresentation] {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONDecoder().decode([NodeJsonRepresentation].self, from: data)
            return jsonObject
        }
        return []
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
