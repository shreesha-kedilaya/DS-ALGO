//
//  LinkedList.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 27/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation
import AVKit
class SingleLinkedListNode<T: Comparable> {
    var value: T
    var next: SingleLinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

class DoubleLinkedListNode<T: Comparable> {
    var value: T
    var prev: DoubleLinkedListNode?
    var next: DoubleLinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

class SingleLinkedList<T: Comparable> {
    typealias Node = SingleLinkedListNode<T>
    var head: Node?
    
    init(array: [T]) {
        for item in array {
            add(value: item)
        }
    }
    
    var count: Int {
        var count = 0
        var currentNode = head
        while let next = currentNode?.next {
            count += 1
            
            currentNode = next
        }
        return count
    }
    
    func add(value: T) {
        guard let head = head else {
            self.head = Node(value: value)
            return
        }
        var lastNode = head
        while let next = lastNode.next  {
            lastNode = next
        }
        
        lastNode.next = Node(value: value)
    }
    
    func search(value: T) -> (current: Node?, previous: Node?)? {
        var currentNode = head
        var previous: Node? = nil
        while let next = currentNode?.next  {
            if next.value == value {
                return (next, previous)
            }
            currentNode = next
            previous = currentNode
        }
        
        return nil
    }
    
    func remove(value: T) {
        if let node = search(value: value) {
            let prev = node.previous
            var current = node.current
            prev?.next = current?.next
            current = nil
        }
    }
}

class DoubleLinkedList<T: Comparable> {
    typealias Node = DoubleLinkedListNode<T>
    var head: Node?
    
    init(array: [T]) {
        for item in array {
            add(value: item)
        }
    }
    
    var count: Int {
        var count = 0
        var currentNode = head
        while let next = currentNode?.next {
            count += 1
            
            currentNode = next
        }
        return count
    }
    
    func add(value: T) {
        guard let head = head else {
            self.head = Node(value: value)
            return
        }
        var lastNode = head
        while let next = lastNode.next  {
            lastNode = next
        }
        let node = Node(value: value)
        node.next = nil
        node.prev = lastNode
        lastNode.next = node
    }
    
    func search(value: T) -> Node? {
        var currentNode = head
        while let next = currentNode?.next  {
            if next.value == value {
                return next
            }
            currentNode = next
        }
        
        return nil
    }
    
    func remove(value: T) {
        var node = search(value: value)
        let nextNode = node?.next
        let prevNode = node?.prev
        nextNode?.prev = prevNode
        prevNode?.next = nextNode
        node = nil
    }
}
