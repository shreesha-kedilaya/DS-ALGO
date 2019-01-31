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
    
    
}
