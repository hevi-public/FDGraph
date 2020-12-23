//
//  DummyDataStore.swift
//  FDGraph
//
//  Created by Hevi on 13/12/2020.
//  Copyright © 2020 Hevi. All rights reserved.
//

import Foundation

class DummyDataStore {
    
    private var nodes: [Node] = []
    
    init() {
        self.nodes = buildDummyData()
    }
    
    public func fetchAll() -> [Node] {
        return nodes
    }
    
    public func fetch(node: Node?) -> Node? {
        return fetchAll().first { _node -> Bool in
            _node == node
        }
    }
    
    public func fetchWith(parent: Node?) -> [Node] {
        return fetch(parent: parent)
    }
    
    private func fetch(parent: Node?) -> [Node] {
        let nodesForParentId = nodes.filter { node -> Bool in
            node.parent == parent
        }

        var result: [Node] = []
        for node in nodesForParentId {
            result.append(node)
            if node.expanded {
                let expandedChildren = fetch(parent: node)
                result.append(contentsOf: expandedChildren)
            }
        }
        return result
    }
    
    func add(node: Node) {
        nodes.append(node)
    }
    
    func save(text: String, parent: Node?, nodeAbove: Node?) {
        let maxId = nodes.filter { node -> Bool in
            node.id != nil
        }.map { node -> Int in
            node.id!
        }.max()
        
        let newNode = Node.init(id: (maxId ?? 0) + 1, parent: parent, text: text, expanded: false, done: false, type: .text)
        
        if let nodeAbove = nodeAbove {
            let row = nodes.firstIndex(of: nodeAbove)! + 1
            nodes.insert(newNode, at: row)
            
            if let parent = parent {
                parent.children.append(newNode)
                parent.expanded = true
            }
        } else {
            nodes.insert(newNode, at: 0)
        }
        
        
    }
    
    public func update(node: Node) {
        
        let possibleIndex = fetchAll().firstIndex { _node -> Bool in
            _node == node
        }
        
        guard let index = possibleIndex else { return }
        
        nodes[index] = node
    }
    
    let loremIpsum = """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla ut pellentesque dui. Vivamus pharetra justo ut ex vehicula euismod. In hac habitasse platea dictumst. Sed sit amet dictum ipsum. Mauris sollicitudin vulputate est eget lacinia. Morbi volutpat et libero eu tincidunt. Suspendisse sodales orci eu arcu dictum, sit amet finibus purus eleifend. Etiam ac dolor quis purus vehicula vehicula.
        """
    
    
    
    private func buildDummyData() -> [Node] {
        
        let nodeWithParent1 = Node(id: 4, text: "row4")
        let nodeWithParent2 = Node(id: 5, text: "row5")
        let nodeParent = Node(id: 3, text: "row3")
        nodeWithParent1.parent = nodeParent
        nodeWithParent2.parent = nodeParent
        
        return [
            Node(id: 1, text: "row1 j jjhk hkhj jkh k,h kuh,uh,uhiuu uiyiuukhjkhjkh khk.j hkjh.k h .jkhkj hjhghjgjg ygug ug ygjhg,jgug, jg,y,ygygy,gjj u kuhkh kjh khkhkhu u"),
            Node(id: 2, text: loremIpsum),
            nodeParent,
            nodeWithParent1,
            nodeWithParent2,
            Node(id: 6, text: "row6"),
            Node(id: 7, text: "row7", done: true),
            Node(id: 8, text: "row8"),
            Node(id: 9, text: "row9"),
            Node(id: 10, text: "row10"),
            Node(id: 11, text: "row11"),
            Node(id: 12, text: "row12"),
            Node(id: 13, text: "row13", done: true),
            Node(id: 14, text: "row14"),
            Node(id: 15, text: "row15"),
            Node(id: 16, text: "row16"),
            Node(id: 17, text: "row17"),
            Node(id: 18, text: "row18"),
            Node(id: 19, text: "row19"),
            Node(id: 20, text: "row20"),
            Node(id: 21, text: "row21"),
            Node(id: 22, text: "row22"),
            Node(id: 23, text: "row23"),
            Node(id: 24, text: "row24"),
            Node(id: 25, text: "row25"),
            Node(id: 26, text: "row26"),
            Node(id: 27, text: "row27"),
            Node(id: 28, text: "row28"),
            Node(id: 29, text: "row29"),
            Node(id: 30, text: "row30"),
            Node(id: 31, text: "row31"),
            Node(id: 32, text: "row32"),
            Node(id: 33, text: "row33"),
            Node(id: 34, text: "row34"),
            Node(id: 35, text: "row35"),
            Node(id: 36, text: "row36"),
            Node(id: 37, text: "row37"),
            Node(id: 38, text: "row38"),
            Node(id: 39, text: "row39"),
            Node(id: 40, text: "row40"),
        ]
    }
}
