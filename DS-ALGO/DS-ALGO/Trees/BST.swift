//
//  BST.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 25/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

class BinarySearchTree<T: Comparable> {
    private(set) var value: T
    var parent: BinarySearchTree<T>?
    var left: BinarySearchTree<T>?
    var right: BinarySearchTree<T>?
    
    init(value: T) {
        self.value = value
    }
    
    convenience init(value: T, parent: BinarySearchTree<T>?) {
        self.init(value: value)
        self.parent = parent
    }
    
    var isLeaf: Bool {
        return left == nil && right == nil
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    // Insert
    
    func insert(value: T) {
        
        if value < self.value {
            if let left = left {
                left.insert(value: value)
            } else {
                left = BinarySearchTree(value: value, parent: self)
            }
        } else {
            if let right = right {
                right.insert(value: value)
            } else {
                right = BinarySearchTree(value: value, parent: self)
            }
        }
    }
    
    // Array insert
    convenience init(array: [T]) {
        self.init(value: array.first!)
        
        for value in array.dropFirst() {
            insert(value: value)
        }
    }
    
    // Search
    
    func search(value: T) -> BinarySearchTree<T>? {
        if value == self.value {
            return self
        } else if value < self.value {
            return left?.search(value: value)
        } else {
            return right?.search(value: value)
        }
    }
    
    // Travarsal
    
    func traverseInOrder(process: (T) -> Void) {
        left?.traverseInOrder(process: process)
        process(value)
        right?.traverseInOrder(process: process)
    }
    
    func traversePreOrder(process: (T) -> Void) {
        process(value)
        left?.traversePreOrder(process: process)
        right?.traversePreOrder(process: process)
    }
    
    func traversePostOrder(process: (T) -> Void) {
        left?.traversePostOrder(process: process)
        right?.traversePostOrder(process: process)
        process(value)
    }
    
    // Map
    
    func map(form: (T) -> T) -> [T] {
        var a = [T]()
        
        if let left = self.left {
            a += left.map(form: form)
        }
        a.append(self.value)
        
        if let right = self.right {
            a += right.map(form: form)
        }
        
        return a
    }
    
    func toArray() -> [T] {
        return map { $0 }
    }
    
    func min() -> BinarySearchTree<T> {
        if let left = self.left {
            return left.min()
        }
        
        return self
    }
    
    func max() -> BinarySearchTree<T> {
        if let right = self.right {
            return right.max()
        }
        
        return self
    }
    
    // Deleting nodes
    @discardableResult
    func remove() -> BinarySearchTree<T>? {
        var replacement: BinarySearchTree<T>?
        
        if let left = self.left {
            replacement = left.max()
        } else if let right = self.right {
            replacement = right.min()
        } else {
            replacement = nil
        }
        
        // This just removes all the connection to the replacement because replacement doesnt have any right left now
        replacement?.remove()
        
        // Place the replacement on current node's position
        replacement?.right = right
        replacement?.left = left
        right?.parent = replacement
        left?.parent = replacement
        reconnectParentTo(node:replacement)
        
        // The current node is no longer part of the tree, so clean it up.
        parent = nil
        left = nil
        right = nil
        
        return replacement
    }
    
    private func reconnectParentTo(node: BinarySearchTree?) {
        if let parent = parent {
            if isLeftChild {
                parent.left = node
            } else {
                parent.right = node
            }
        }
        node?.parent = parent
    }
    // Depth/Height
    
    func height() -> Int {
        if isLeaf {
            return 0
        } else {
            return 1 + Swift.max(left?.height() ?? 0, right?.height() ?? 0)
        }
    }
    
    func depth() -> Int {
        var node = self
        var edges = 0
        while let parent = node.parent {
            node = parent
            edges += 1
        }
        return edges
    }
    
    // Predecessor
    
    // Successor
    
    // isBst:- All 3
    
    func isBstAmature() -> Bool {
        if let left = left, left.max().value > self.value {
            return false
        }
        
        if let right = right, right.min().value < self.value {
            return false
        }
        
        if (left?.isBstAmature() ?? true) || (right?.isBstAmature() ?? true) {
            return true
        }
        
        return true
    }
    
    func isBst(leftNode: BinarySearchTree<T>?, rightNode: BinarySearchTree<T>?) -> Bool {
        
        if let leftNode = leftNode, !(self.value > leftNode.value) {
            return false
        }
        
        if let rightNode = rightNode, !(self.value <= rightNode.value) {
            return false
        }
        
        // The nilcolasing ?? operator defines if left is nil and right is nil
        if (left?.isBst(leftNode: leftNode, rightNode: self) ?? true) && (right?.isBst(leftNode: self, rightNode: rightNode) ?? true) {
            return true
        }
        
        return false
    }
}

extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var s = ""
        if let left = left {
            s += "(\(left.description)) <- "
        }
        s += "\(value)"
        if let right = right {
            s += " -> (\(right.description))"
        }
        return s
    }
}
