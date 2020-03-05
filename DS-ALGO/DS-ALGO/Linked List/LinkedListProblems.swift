//
//  LinkedListProblems.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 27/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

//https://www.ideserve.co.in/learn/maximum-element-from-each-subarray-of-size-k-set-2
//Find maximum element from each sub-array of size 'k'| Set 2

/*
 
 If you are given an integer array and an integer 'k' as input, write a program to print elements with maximum values from each possible
 sub-array (of given input array) of size 'k'. If the given input array is {9,6,11,8,10,5,14,13,93,14} and for k = 4, output
 should be 11,11,11,14,14,93,93. Please observe that 11 is the largest element in the first, second and third sub-arrays - {9,6,11,8},
 {6,11,8,10} and {11,8,10,5}; 14 is the largest element for fourth and fifth sub-array and 93 is the largest element for remaining sub-arrays.
 
 */

func findMaxElementsFromSubArray<T: Comparable>(array: [T], size: Int) -> [T] {
    var combined = [T]()
    let queue = SimpleQueue<Int>() // This is a Dequeue
    for i in 0..<size {
        
        while !queue.isEmpty && array[i] > array[queue.last!] {
            _ = queue.dequeueBack()
        }
        
        queue.enqueue(i)
    }
    
    for i in size..<array.count {
        if let front = queue.front {
            combined.append(array[front])
        }
        
        while !queue.isEmpty && queue.front ?? 0 <= i-size {
            _ = queue.dequeue()
        }
        
        while !queue.isEmpty && array[i] > array[queue.last!] {
            _ = queue.dequeueBack()
        }
        
        queue.enqueue(i)
    }
    
    // Add the max for the last combination of array
    if let front = queue.front {
        combined.append(array[front])
    }
    
    return combined
}

//https://www.ideserve.co.in/learn/sum-of-two-linked-lists-using-recursion-set-2
//Sum of Two Linked Lists using Recursion | Set 2

//In this post we have covered the recursive solution for finding out sum of numbers represented by linked lists. In that question though, a number was represented in such a way that its unit digit was placed at the end of the linked list. For example, number 98734 would be represented as 9->8->7->3->4.
//
//In this problem, a number is represented in reverse fashion, that is its unit digit is placed at the beginning of the linked list. For example, number 98734 is represented as 4->3->7->8->9. Given this representation, write a program that takes input as two linked lists(which represent two numbers) and returns output as the linked list which is sum of two numbers represented by input linked lists.
//
//Example:
//Input: 1->7->9->9->9->null(number 99971), 8->9->9->null(number 998).
//Output: 9->6->9->0->0->1->null(number 100969)

func findSumOfLists(firstList: SingleLinkedListNode<Int>?, secondList: SingleLinkedListNode<Int>?, carry: Int) -> SingleLinkedListNode<Int>? {
    if firstList == nil && secondList == nil {
        if carry > 0 {
            return SingleLinkedListNode<Int>.init(value: carry)
        }
        return nil
    }
    
    var sum = (firstList?.value ?? 0) + (secondList?.value ?? 0) + carry
    let carrySum = sum / 10
    sum = sum % 10
    
    var currentNode = SingleLinkedListNode<Int>.init(value: sum)
    
    currentNode.next = findSumOfLists(firstList: firstList?.next, secondList: secondList?.next, carry: carrySum)
    
    return currentNode
}

//https://www.ideserve.co.in/learn/find-nth-node-from-the-end-of-linked-list
//Given a linked list, find 'n'th node from the end for a given value of n (n > 0). For example, for the following linked list
// 1-> 2-> 3 -> 4 -> 5 -> 6 -> 7
//if n = 2, we have to find 2nd node from the end which is node 6.
//if n = 1, we have to find 1st node from the end which is node 7.


func findNthFromEnd(n: Int, node: SingleLinkedList<Int>) -> Int? {
    var node1 = node.head
    var node2 = node.head
    var count = 1
    
    while node1?.next != nil {
        if count == n + 1 {
            break
        }
        count += 1
        node1 = node1?.next
    }
    
    if (count == (n+1))
    {
        while (node1 != nil)
        {
            node1 = node1?.next
            node2 = node2?.next
        }
         
        return node2?.value;
    }
    
    return nil
}

//https://www.ideserve.co.in/learn/sum-of-two-linked-lists-using-recursion-set-1
//Sum of Two Linked Lists using Recursion | Set 1 -> Remaining


//https://www.ideserve.co.in/learn/reverse-a-linked-list-iterative
//Given two numbers which are represented using linked lists as shown below. Return the reference to a new linked list which stores the sum of given two numbers. You are not allowed to make use of explicit extra space except temporary variables.
//
//Numbers are represented as following:
//Number 98976, corresponding linked list: 9->8->9->7->6->null
//Number 198,   corresponding linked list: 1->9->8->null
//
//The output returned by the program for above two linked lists as input should be the linked list 9->9->1->7->4->null
//


