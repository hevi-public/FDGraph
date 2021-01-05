//
//  DataStore.swift
//  FDGraph
//
//  Created by Hevi on 05/01/2021.
//  Copyright © 2021 Hevi. All rights reserved.
//

import Foundation
protocol DataStore {
    
    func fetchAll() -> [Node]
    func fetch(node: Node?) -> Node?
    func fetchWith(parent: Node?) -> [Node]
    func add(node: Node)
    func save(text: String, parent: Node?, nodeAbove: Node?)
    func update(node: Node)
}
