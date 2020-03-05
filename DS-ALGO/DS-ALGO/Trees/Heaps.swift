//
//  Trees.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 14/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

//If you didn't gloss over the math section, you'd have seen that for any heap the elements at array indices n/2 to n-1 are the leaves of the tree. We can simply skip those leaves. We only have to process the other nodes, since they are parents with one or more children and therefore may be in the wrong order.
// https://github.com/raywenderlich/swift-algorithm-club/tree/master/Heap

struct HeapNode<T: Comparable> {
    var value: T
    var payLoad: Any?
    
    init(value: T, payload: Any? = nil) {
        self.value = value
        self.payLoad = payload
    }

}

struct Heap<T: Comparable> {
    
    var nodes = [HeapNode<T>]()
    private var orderCriteria: (T, T) -> Bool
    // Returns the parent of the child.
    // May be empty also
    func parentIndex(ofIndex i: Int) -> Int {
        return (i - 1) / 2
    }
    
    // Returns the left child of parent.
    // May be empty also
    func leftChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 1
    }
    
    // Returns the right child of parent.
    // May be empty also
    func rightChildIndex(ofIndex i: Int) -> Int {
        return 2*i + 2
    }
    
    init(tupleList: [(T, Any)], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        tupleList.forEach { (value, payLoad) in
            nodes.append(HeapNode<T>.init(value: value, payload: payLoad))
        }
        
        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    init(array: [T], sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
        configureHeap(from: array)
    }
    
    private mutating func configureHeap(from array: [T]) {
        array.forEach { (value) in
            nodes.append(HeapNode<T>.init(value: value))
        }
        for i in stride(from: (nodes.count/2-1), through: 0, by: -1) {
            shiftDown(i)
        }
    }
    
    init(sort: @escaping (T, T) -> Bool) {
        self.orderCriteria = sort
    }
    
    mutating func insert(_ value: T) {
        nodes.append(HeapNode<T>.init(value: value))
        shiftUp(nodes.count - 1)
    }
    
    mutating func insert(_ value: T, payload: Any) {
        nodes.append(HeapNode<T>.init(value: value, payload: payload))
        shiftUp(nodes.count - 1)
    }
    
    // Shifting up to balance the heap.
    mutating func shiftUp(_ index: Int) {
        var childIndex = index
        let child = nodes[childIndex]
        var parentIndex = self.parentIndex(ofIndex: childIndex)
        
        while childIndex > 0 && orderCriteria(child.value, nodes[parentIndex].value) {
            nodes[childIndex] = nodes[parentIndex]
            childIndex = parentIndex
            parentIndex = self.parentIndex(ofIndex: childIndex)
        }
        
        nodes[childIndex] = child
    }
    
    public func peek() -> HeapNode<T>? {
        return nodes.first
    }
    
    public mutating func replace(index i: Int, value: T) {
        guard i < nodes.count else { return }
        
        remove(at: i)
        insert(value)
    }
    
    
    @discardableResult mutating func remove() -> HeapNode<T>? {
        guard !nodes.isEmpty else { return nil }
        
        if nodes.count == 1 {
            return nodes.removeLast()
        } else {
            // Use the last node to replace the first one, then fix the heap by
            // shifting this new first node into its proper position.
            let value = nodes[0]
            nodes[0] = nodes.removeLast()
            shiftDown(0)
            return value
        }
    }
    
    @discardableResult mutating func remove(at index: Int) -> HeapNode<T>? {
        guard index < nodes.count else {return  nil}
        
        let size = nodes.count - 1
        
        if index != size {
            nodes.swapAt(index, size)
            
            shiftDown(index)
            shiftUp(index)
        }
        
        return nodes.removeLast()
    }
    
    internal mutating func shiftDown(from index: Int, until endIndex: Int) {
        let leftChildIndex = self.leftChildIndex(ofIndex: index)
        let rightChildIndex = leftChildIndex + 1
        
        // Figure out which comes first if we order them by the sort function:
        // the parent, the left child, or the right child. If the parent comes
        // first, we're done. If not, that element is out-of-place and we make
        // it "float down" the tree until the heap property is restored.
        var first = index
        if leftChildIndex < endIndex && orderCriteria(nodes[leftChildIndex].value, nodes[first].value) {
            first = leftChildIndex
        }
        if rightChildIndex < endIndex && orderCriteria(nodes[rightChildIndex].value, nodes[first].value) {
            first = rightChildIndex
        }
        if first == index { return }
        
        nodes.swapAt(index, first)
        shiftDown(from: first, until: endIndex)
    }
    
    mutating func shiftDown(_ index: Int) {
        shiftDown(from: index, until: nodes.count)
    }
}

extension Heap {
    
    mutating func sortUntil(index: Int, elements: (HeapNode<T>) -> Void) -> [HeapNode<T>] {
        for i in stride(from: (nodes.count - 1), through: nodes.count - index, by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
            elements(nodes[i])
        }
        return nodes
    }
    
    mutating func sort() -> [HeapNode<T>] {
        for i in stride(from: (nodes.count - 1), through: 1, by: -1) {
            nodes.swapAt(0, i)
            shiftDown(from: 0, until: i)
        }
        return nodes
    }
}

