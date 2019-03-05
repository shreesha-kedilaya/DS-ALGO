//
//  Stacks:Queues.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 31/01/19.
//  Copyright © 2019 Shreesha Kedlaya. All rights reserved.
//

import Foundation

// MARK: Simple Stack.
class SimpleStack<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public func push(_ element: T) {
        array.append(element)
    }
    
    public func pop() -> T? {
        return array.popLast()
    }
    
    public var top: T? {
        return array.last
    }
}

extension SimpleStack: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        let curr = self
        return AnyIterator {
            return curr.pop()
        }
    }
}

// MARK: Simple Queue.
class SimpleQueue<T> {
    private var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public func enqueue(_ element: T) {
        array.append(element)
    }
    
    public func dequeue(_ element: T) -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
    public var front: T? {
        return array.first
    }
}

class Queue<T> {
    private var array = [T?]()
    private var head = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    public var count: Int {
        return array.count - head
    }
    
    public func enqueue(_ element: T) {
        array.append(element)
    }
    
    public func dequeue() -> T? {
        guard head < array.count, let element = array[head] else { return  nil }
        
        array[head] = nil
        head += 1
        
        let percentage = Double(head)/Double(array.count)
        if array.count > 50 && percentage > 0.25 {
            array.removeFirst(head)
            head = 0
        }
        
        return element
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
}
