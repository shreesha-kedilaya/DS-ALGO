
//
//  ArrayProblems.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 04/03/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation
//https://www.ideserve.co.in/learn/print-matrix-diagonally
/*
Input Matrix
[1, 2, 3, 4, 5]
[6, 7, 8, 9, 10]
[11, 12, 13, 14, 15]
[16, 17, 18, 19, 20]

Printing Matrix Diagonally
1
6 2
11 7 3
16 12 8 4
17 13 9 5
18 14 10
19 15
20
 
*/


func printMatrixDiagonally(matrix: [[Int]]) {
    
    let rowCount = matrix.count
    let columnCount = matrix[0].count
    
    for k in 0..<rowCount {
        var row = k
        var column = 0
        while row >= 0 && column < columnCount {
            print("\(matrix[row][column]) ", terminator: "")
            row -= 1
            column += 1
        }
        print("\n")
    }

    for k in 1..<columnCount {
        var row = rowCount - 1
        var column = k
        while row >= 0 && column < columnCount {
            print("\(matrix[row][column]) ", terminator: "")
            row -= 1
            column += 1
        }
        print("\n")
    }
    
}

//https://www.ideserve.co.in/learn/number-of-clusters-of-1s

//Given a 2D matrix of 0s and 1s, find total number of clusters formed by elements with value 1.  For example, in the below shown 2D matrix there are total three such clusters.
//
//This problem is also known as 'Number of Islands' problem.

class IslandProblem {
    
    var visited = [[Bool]]()
    func findNumberOfClusters(matrix: [[Int]]) -> Int {
        var count = 0
        visited = [[Bool]].init(repeating: [false, false, false], count: matrix.count)
        for rowArray in matrix.enumerated() {
            for item in rowArray.element.enumerated() {
                if item.element == 1 && visited[rowArray.offset][item.offset] == false {
                    count += 1
                    doDfs(matrix: matrix, row: rowArray.offset, column: item.offset)
                }
            }
        }
        
        return count
    }
    
    func doesNeighbourExistsAs1(matrix:[[Int]], row: Int, column: Int) -> Bool {
        if row >= 0 && row < matrix.count && column >= 0 && column < matrix[0].count {
            if matrix[row][column] == 1 {
                return true
            }
        }
        
        return false
    }
    
    func doDfs(matrix: [[Int]], row: Int, column: Int) {
        if visited[row][column] {
            return
        }
        
        visited[row][column] = true
        
        for i in -1...1 {
            for j in -1...1 {
                if doesNeighbourExistsAs1(matrix: matrix, row: row + i, column: column + j) {
                    doDfs(matrix: matrix, row: row + 1, column: column + 1)
                }
            }
        }
    }
}

//https://www.ideserve.co.in/learn/find-the-nth-most-frequent-number-in-array

//Given an array of numbers and a positive integer 'n', find 'n'th most frequent occurring number in that array. If there are more than one numbers which are occurring 'n'th most frequently, then you can return any one of such integers.
//
//Example:  For the input array {1,2,2,2,4,4,4,4,5,5,5,5,5,7,7,8,8,8,8}
//if n = 1, then the o/Users/shreeshak/Shreesha/Algo/DS-ALGO/DS-ALGO/DS-ALGO/Stacks Queues/StacksQueues.swiftutput returned should be 5 because it is the most frequent number,
//if n = 2, output can be either 4 or 8 since any of these numbers could be considered as the 2nd most frequent number,
//if n = 3, again output can be either 4 or 8
//if n = 4, output should be 2.

func findNthMostFrequentNumber(array: [Int], n: Int) -> Int? {
    guard !array.isEmpty else { return nil}
    
    var frequencyDict = [Int:Int]()
    
    for element in array {
        if let frequency = frequencyDict[element] {
            frequencyDict[element] = frequency + 1
        } else {
            frequencyDict[element] = 1
        }
    }
    var heap = Heap<Int>.init(sort: >)
    for element in frequencyDict {
        heap.insert(element.value, payload: element.key)
    }
    
    print(heap.sort())
    
    return heap.nodes[heap.nodes.count - n].payLoad as? Int
}

//https://www.ideserve.co.in/learn/next-great-element-in-an-array
/*
 Given an array of integers(positive or negative), print the next greater element of all elements in the array. If there is no greater element then print null.
Next greater element of an array element array[i], is an integer array[j], such that
1. array[i] < array[j]
2. i < j
3. j - i is minimum
i.e. array[j] is the first element on the right of array[i] which is greater than array[i].
For example:
Input array:  98, 23, 54, 12, 20, 7, 27
Output:
Next greater element for 23     = 54
Next greater element for 12     = 20
Next greater element for 7     = 27
Next greater element for 20     = 27
Next greater element for 27     = null
Next greater element for 54     = null
Next greater element for 98     = null
 */
