//
//  TreeProblems.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 17/03/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

//https://www.ideserve.co.in/learn/spiral-level-order-traversal-of-a-binary-tree-set-1
//Spiral Level Order Traversal of a Binary Tree | Set 1
//Given a binary tree, write a program to print nodes of the tree in spiral order. For example, for the following tree
//
//output should be 0,1,2,6,3,5,4,7,8,9.

func spiralOrderTravarsal(treeNode: TreeNode<Int>) -> [Int?] {
    let evenStack = SimpleStack<TreeNode<Int>>()
    let oddStack = SimpleStack<TreeNode<Int>>()
    evenStack.push(treeNode)
    var outputArray = [Int?]()
    
    var evenLevel = true
    
    while !evenStack.isEmpty || !oddStack.isEmpty {
        if evenLevel {
            while !evenStack.isEmpty {
                let currentNode = evenStack.pop()
                outputArray.append(currentNode?.value)
                
                if let right = currentNode?.right {
                    oddStack.push(right)
                }
                
                if let left = currentNode?.left {
                    oddStack.push(left)
                }
            }
        } else {
            while !oddStack.isEmpty {
                let currentNode = oddStack.pop()
                outputArray.append(currentNode?.value)
                
                if let left = currentNode?.left {
                    evenStack.push(left)
                }
                
                if let right = currentNode?.right {
                    evenStack.push(right)
                }
            }
        }
        
        evenLevel = !evenLevel
    }
    
    return outputArray
}

func spiralLevelRecursion(treeNode: TreeNode<Int>) -> [Int?] {
    let totalLevel = treeNode.depth()
    var outputArray = [Int?]()
    var rightToLeft = true
    for i in 0..<totalLevel {
        let array = printCurrentLevelElements(node: treeNode, currentLevel: 0, currentMaxLevel: i, rightToLeft: rightToLeft)
        outputArray.append(contentsOf: array)
        rightToLeft = !rightToLeft
    }
    return outputArray
}

func printCurrentLevelElements(node: TreeNode<Int>?, currentLevel: Int, currentMaxLevel: Int, rightToLeft: Bool) -> [Int?] {
    
    var outputArray = [Int?]()
    
    guard let node = node else {
        return []
    }
    
    if currentLevel == currentMaxLevel {
        outputArray.append(node.value)
        return outputArray
    }
    
    var array1 = [Int?]()
    var array2 = [Int?]()
    
    if rightToLeft {
        array1 = printCurrentLevelElements(node: node.right, currentLevel: currentLevel + 1, currentMaxLevel: currentMaxLevel, rightToLeft: rightToLeft)
        array2 = printCurrentLevelElements(node: node.left, currentLevel: currentLevel + 1, currentMaxLevel: currentMaxLevel, rightToLeft: rightToLeft)
    } else {
        array1 = printCurrentLevelElements(node: node.left, currentLevel: currentLevel + 1, currentMaxLevel: currentMaxLevel, rightToLeft: rightToLeft)
        array2 = printCurrentLevelElements(node: node.right, currentLevel: currentLevel + 1, currentMaxLevel: currentMaxLevel, rightToLeft: rightToLeft)
    }
    outputArray = array1 + array2
    return outputArray
}

//https://www.ideserve.co.in/learn/lowest-common-ancestor-of-two-nodes-binary-search-tree
//Lowest Common Ancestor of two nodes in a Binary Search Tree
//Find Lowest Common Ancestor(LCA) of given two nodes in a Binary Search Tree(BST). The lowest common ancestor (LCA) of two nodes 'n1' and 'n2' in a tree is the lowest(i.e. deepest) node that has both 'n1' and 'n2' as descendants. Each node is considered descendant of itself. So if 'n1' is descendant of 'n2' then LCA of 'n1' and 'n2' would be 'n2' and vice versa (Credits for definition of LCA: Wikipedia).
//
//Let's look at couple of examples to understand definition of LCA more clearly.
//
//In the above BST,
//LCA of nodes '0' and '3' is node '2'.
//LCA of nodes '0' and '1' is node '0'.
//LCA of nodes '3' and '9' is node '5'.
//LCA of nodes '5' and '3' is node '5'.

func findLCA<T: Comparable>(currentNode: TreeNode<T>?, n1: TreeNode<T>, n2: TreeNode<T>) -> TreeNode<T>? {
    
    guard let currentNode = currentNode else {
        return nil
    }
    
    if n1.value < currentNode.value && n2.value > currentNode.value {
        return currentNode
    } else if n1.value == currentNode.value || n2.value == currentNode.value {
        return currentNode
    }
    
    var lcaNode: TreeNode<T>?
    
    if n2.value < currentNode.value {
        lcaNode = findLCA(currentNode: currentNode.left, n1: n1, n2: n2)
    } else {
        lcaNode = findLCA(currentNode: currentNode.right, n1: n1, n2: n2)
    }
    
    return lcaNode
}

//https://www.ideserve.co.in/learn/populate-right-neighbors-in-a-binary-tree
//Populate right neighbors for all nodes in a binary tree

//Given a binary tree with each node having a reference for its 'neighbor' node along with left and right child nodes. A 'neighbor' node for node 'n' is defined as the node located on the immediate right hand side of node 'n'. A node and its neighbor node would be on the same level. If there is no node located on the immediate right hand side of node 'n', then neighbor of node 'n' is null.

func populateRightNeighbours(root: TreeNode<Int>?) {
    
    guard let root = root else {
        return
    }
    
    if let left = root.left {
        if let right = root.right {
            left.neighbour = right
        } else {
            var parentNeighbour = root.neighbour
            
            while parentNeighbour != nil {
                let neighbour = parentNeighbour?.left != nil ? parentNeighbour?.left: parentNeighbour?.right
                
                if let neighbour = neighbour {
                    left.neighbour = neighbour
                    break
                }
                
                parentNeighbour = parentNeighbour?.neighbour
            }
        }
    }
    
    if let right = root.right {
        var parentNeighbour = root.neighbour
        
        while parentNeighbour != nil {
            let neighbour = parentNeighbour?.left != nil ? parentNeighbour?.left: parentNeighbour?.right
            
            if let neighbour = neighbour {
                right.neighbour = neighbour
                break
            }
            
            parentNeighbour = parentNeighbour?.neighbour
        }
    }
}
