//
//  AVL tree.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 25/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

public class TreeNode<T: Comparable> {
    public typealias Node = TreeNode<T>
        
    var value: T   // Node's name
    var left: Node?
    var right: Node?
    var height: Int
    weak var parent: Node?
    
    public init(value: T, leftChild: Node?, rightChild: Node?, parent: Node?, height: Int) {
        self.value = value
        self.left = leftChild
        self.right = rightChild
        self.parent = parent
        self.height = height

        self.left?.parent = self
        self.right?.parent = self
    }
    
    public convenience init(value: T) {
        self.init(value: value, leftChild: nil, rightChild: nil, parent: nil, height: 1)
    }
    
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeaf: Bool {
        return right == nil && left == nil
    }
    
    var isLeftChild: Bool {
        return parent?.left === self
    }
    
    var isRightChild: Bool {
        return parent?.right === self
    }
    
    var hasLeftChild: Bool {
        return left != nil
    }
    
    var hasRightChild: Bool {
        return right != nil
    }
    
    var hasAnyChild: Bool {
        return left != nil || right != nil
    }
    
    var hasBothChildren: Bool {
        return left != nil && right != nil
    }
    
    func min() -> TreeNode<T> {
        if let left = self.left {
            return left.min()
        }
        
        return self
    }
    
    func max() -> TreeNode<T> {
        if let right = self.right {
            return right.max()
        }
        
        return self
    }
}

class AVLTree<T: Comparable> {
    public typealias Node = TreeNode<T>
    var root: Node?
    
    private(set) var size = 0
    
    init() { }
    
    func insert(value: T) {
        if let root = root {
            insert(value: value, node: root)
        } else {
            root = Node(value: value)
        }
        size += 1
    }
    
    private func insert(value: T, node: Node) {
        if value < node.value {
            if let left = node.left {
                insert(value: value, node: left)
            } else {
                node.left = Node(value: value, leftChild: nil, rightChild: nil, parent: node, height: 1)
                // balance
            }
        } else {
            if let right = node.right {
                insert(value: value, node: right)
            } else {
                node.right = Node(value: value, leftChild: nil, rightChild: nil, parent: node, height: 1)
                // balance
            }
        }
    }
    
    private func updateHeightUpwards(node: Node?) {
        if let node = node {
            let lHeight = node.left?.height ?? 0
            let rHeight = node.right?.height ?? 0
            node.height = max(lHeight, rHeight) + 1
            updateHeightUpwards(node: node.parent)
        }
    }
    
    private func lrDifference(node: Node?) -> Int {
        let lHeight = node?.left?.height ?? 0
        let rHeight = node?.right?.height ?? 0
        return lHeight - rHeight
    }
    
    func balance(node: Node?) {
        guard let node = node else {
            return
        }
        
        updateHeightUpwards(node: node.left)
        updateHeightUpwards(node: node.right)
        
        var rotationHead: Node?
        var rotationPin: Node?
        var firstNode: Node?
        
        var subTree1: Node?
        var subTree2: Node?
        var subTree3: Node?
        var subTree4: Node?
        
        let parentNode = node.parent
        
        // Find the 3 pivotal nodes
        let lrFactor = lrDifference(node: node)
        if lrFactor > 1 {
            // left-left or left-right
            if lrDifference(node: node.left) > 0 {
                // left-left
                firstNode = node
                rotationHead = node.left
                rotationPin = node.left?.left
                
                subTree1 = rotationPin?.left
                subTree2 = rotationPin?.right
                subTree3 = rotationHead?.right
                subTree4 = firstNode?.right
            } else {
                // left-right
                firstNode = node
                rotationPin = node.left
                rotationHead = node.left?.right
                
                subTree1 = rotationPin?.left
                subTree2 = rotationHead?.left
                subTree3 = rotationHead?.right
                subTree4 = firstNode?.right
            }
            
        } else if lrFactor < -1 {
                   // right-left or right-right
            if lrDifference(node: node.right) < 0 {
                // right-right
                rotationPin = node
                rotationHead = node.right
                firstNode = node.right?.right
                
                subTree1 = rotationPin?.left
                subTree2 = rotationHead?.left
                subTree3 = firstNode?.left
                subTree4 = firstNode?.right
            } else {
                // right-left
                rotationPin = node
                firstNode = node.right
                rotationHead = node.right?.right
                
                subTree1 = rotationPin?.left
                subTree2 = rotationHead?.left
                subTree3 = rotationHead?.right
                subTree4 = firstNode?.right
            }
        } else {
            // Don't need to balance 'node', go for parent
            balance(node: node.parent)
            return
        }
        
        // Swaping the nodes with head and its parent
        if node.isRoot {
            root = rotationHead
            root?.parent = nil
        } else if node.isLeftChild {
            parentNode?.left = rotationHead
            rotationHead?.parent = parentNode
        } else if node.isRightChild {
            parentNode?.right = rotationHead
            rotationHead?.parent = parentNode
        }
        // Rotate
        
        rotate(head: rotationHead, pin: rotationPin, first: firstNode, subTree1: subTree1, subTree2: subTree2, subTree3: subTree3, subTree4: subTree4)
        
        updateHeightUpwards(node: rotationPin)    // Update height from left
        updateHeightUpwards(node: firstNode)    // Update height from right
        
        balance(node: rotationHead?.parent)
    }
    
    func rotate(head: Node?, pin: Node?, first: Node?,
        subTree1: Node?, subTree2: Node?, subTree3: Node?, subTree4: Node?) {
        head?.left = pin
        pin?.parent = head
        head?.right = first
        first?.parent = head
        
        pin?.left = subTree1
        subTree1?.parent = pin
        pin?.right = subTree2
        subTree2?.parent = pin
        
        first?.left = subTree3
        subTree3?.parent = first
        first?.right = subTree4
        subTree4?.parent = first
    }
    
    func delete(node: Node) {
        if node.isLeaf {
            // Just remove and balance up
            if let parent = node.parent {
                guard node.isLeftChild || node.isRightChild else {
                    // just in case
                    fatalError("Error: tree is invalid.")
                }
                
                if node.isLeftChild {
                    parent.left = nil
                } else if node.isRightChild {
                    parent.right = nil
                }
                
                balance(node: parent)
            } else {
                // at root
                root = nil
            }
        } else {
            // Handle stem cases
            if let replacement = node.left?.max(), replacement !== node {
                node.value = replacement.value
//                node.payload = replacement.payload
                delete(node: replacement)
            } else if let replacement = node.right?.min(), replacement !== node {
                node.value = replacement.value
//                node.payload = replacement.payload
                delete(node: replacement)
            }
        }
    }
}
