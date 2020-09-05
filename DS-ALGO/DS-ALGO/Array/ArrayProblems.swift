
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
[1,  2,  3,  4,  5]
[6,  7,  8,  9,  10]
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
        let array = [Bool].init(repeating: false, count: matrix[0].count)
        visited = [[Bool]].init(repeating: array, count: matrix.count)
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
                    doDfs(matrix: matrix, row: row + i, column: column + j)
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



//https://www.ideserve.co.in/learn/last-index-of-element-in-sorted-array-with-duplicates

/*
 Given a sorted array of integers containing duplicates, write a program which returns the last index of an element.

 Example:
 Input:
 array = {0, 1, 2, 2, 4, 5, 5, 5, 8};
 num = 5;
 Output:
 Element 5 found at index 7
 */

func searchElementAndReturnMaxIndex(array: [Int], number: Int) -> Int? {
    guard !array.isEmpty else { return nil }
    
    var start = 0
    var end = array.count - 1
    
    while start <= end {
        let mid = (start + end) / 2
        
        if array[mid] == number && (mid == end || (array[mid + 1] > number)) {
            return mid
        } else if number < array[mid] {
            end = mid - 1
        } else if number >= array[mid] {
            start = mid + 1
        }
    }
    
    return nil
}

//https://www.ideserve.co.in/learn/first-index-of-element-in-sorted-array-with-duplicates

func searchElementAndReturnMinIndex(array: [Int], number: Int) -> Int? {
    guard !array.isEmpty else { return nil }
    
    var start = 0
    var end = array.count - 1
    
    while start <= end {
        let mid = (start + end) / 2
        
        if array[mid] == number && (mid == 0 || (array[mid - 1] < number)) {
            return mid
        } else if number <= array[mid] {
            end = mid - 1
        } else if number > array[mid] {
            start = mid + 1
        }
    }
    
    return nil
}

//https://www.ideserve.co.in/learn/maximum-value-of-index-element-product-sum-with-only-rotations

/*
 Given an array, find the maximum possible value of sum of index-element-products(i*array[i]) with only rotations allowed on a given array. Sum of index-element-products for array of length 'n' is computed as - 0*array[0] + 1*array[1] + 2*array[2] + ... + n-1*array[n-1].

 For example, for the array {3,4,5,6,1,2} without doing any rotations sum of index-element-products is 46. After doing one clockwise rotation of the array, it would be modified to {2,3,4,5,6,1} and sum of index-element-products in this case is 55.
 As you should be able to confirm, maximum value of sum of index-element-products for this given array is 70 which is obtained after performing two clockwise rotations in which case modified array is {1,2,3,4,5,6}.

 For the array {24,26,25,22},
 index-element-products sum without any rotation is 142. The maximum sum of index-element-products that could be obtained is 151 which is obtained with one clockwise rotation(modified array {22,24,26,25}).
 */

func findMaxIndexElementProductSum(array: [Int]) -> Int {
    
    var sumOfAllElements = 0
    var sumOfIndexProducts = 0
    
    for item in array.enumerated() {
        sumOfAllElements += item.element
        sumOfIndexProducts += item.offset * item.element
    }
    
    var maxValue = sumOfIndexProducts
 
    for i in 1..<array.count {
        sumOfIndexProducts += sumOfAllElements - array.count * array[array.count - i]
        
        if sumOfIndexProducts > maxValue {
            maxValue = sumOfIndexProducts
        }
    }
    
    return maxValue
}

//https://www.ideserve.co.in/learn/maximum-size-square-sub-matrix-with-all-1s
/*
 Given a matrix of dimensions mxn having all entries as 1 or 0, find out the size of maximum size square sub-matrix with all 1s.

 Please check out the video below for detailed explanation of the algorithm with animations.
 */

func maximumSizeSquareSubmatrixWithAllOnes(matrix: [[Int]]) -> Int {
    var maxSize = 0
    let linearElements = [Int].init(repeating: 0, count: matrix[0].count)
    var storingTable = [[Int]].init(repeating: linearElements, count: matrix.count)
    
    for rowArray in matrix.enumerated() {
        for items in rowArray.element.enumerated() {
            if rowArray.offset == 0 || items.offset == 0 {
                storingTable[rowArray.offset][items.offset] = matrix[rowArray.offset][items.offset]
                maxSize = storingTable[rowArray.offset][items.offset] > maxSize ? storingTable[rowArray.offset][items.offset] : maxSize
            } else if matrix[rowArray.offset][items.offset] == 0 {
                storingTable[rowArray.offset][items.offset] = 0
            } else {
                
                storingTable[rowArray.offset][items.offset] = min(storingTable[rowArray.offset-1][items.offset-1], storingTable[rowArray.offset-1][items.offset], storingTable[rowArray.offset][items.offset - 1]) + 1
                
                maxSize = storingTable[rowArray.offset][items.offset] > maxSize ? storingTable[rowArray.offset][items.offset] : maxSize
            }
        }
    }
    
    return maxSize
}

//https://www.ideserve.co.in/learn/maximum-average-subarray
/*
 Given an integer array and a number k, print the maximum sum subarray of size k.
 Maximum average subarray of size k is a subarray (sequence of contiguous elements in the array) for which the average is maximum among all subarrays of size k in the array.
 Average of k elements = (sum of k elements)/k
 Since k > 0, the maximum sum subarray of size k will also be maximum average subarray of size k. So, the problem reduces to finding maximum sum subarray of size k in the array.
 */

func getMaxAvgSubarrayStartIndex(array: [Int], size: Int) -> [Int] {
    if size == array.count {
        return array
    }
    
    var sum = 0
    
    for i in 0..<size {
        sum += array[i]
    }
    
    var maxSum = sum
    var maxSumIndex = 0
    
    for i in size..<array.count {
        sum = sum - array[i-size] + array[i]
        
        if maxSum < sum {
            maxSum = sum
            maxSumIndex = i - size
        }
    }
    
    return Array(array[maxSumIndex+1...(maxSumIndex + size)])
}

//https://www.ideserve.co.in/learn/find-common-elements-in-n-sorted-arrays
/*
Given 'n' sorted arrays, find elements which are common in all of these 'n' arrays. For example,

{23, 34, 67, 89, 123, 566, 1000},
{11, 22, 23, 24,33, 37, 185, 566, 987, 1223, 1234},
{23, 43, 67, 98, 566, 678},
{1, 4, 5, 23, 34, 76, 87, 132, 566, 665},
{1, 2, 3, 23, 24, 344, 566}
for these given arrays, output should be 23 and 566 since these elements are present in all arrays.

{1, 3, 4, 4, 5, 43, 67, 98, 566, 678},
{1, 4, 4, 5, 23, 34, 76, 87, 132, 566, 665},
{1, 2, 4, 4, 5, 23, 24, 344, 566}
For above arrays, output should be 1,4,4,5,566,
*/

func printCommonElements(matrix: [[Int]]) -> [Int] {
    
    var firstArrayCounter = 0
    
    var indexStoreArray = [Int].init(repeating: 0, count: matrix.count)
    var returnArray = [Int]()
    var smallestArrayTraversed = false
    
    while firstArrayCounter < matrix[0].count && !smallestArrayTraversed {
        var totalMatchFound = 0
        
        for i in 1..<matrix.count {
            var currentIndex = indexStoreArray[i-1]
            
            while currentIndex < matrix[i].count && matrix[i][currentIndex] < matrix[0][firstArrayCounter] {
                currentIndex += 1
            }
            
            if currentIndex < matrix[i].count {
                if matrix[i][currentIndex] == matrix[0][firstArrayCounter]
                {
                    totalMatchFound += 1;
                }
            } else {
                smallestArrayTraversed = true
            }
            indexStoreArray[i-1] = currentIndex
        }
        
        if totalMatchFound == matrix.count - 1 {
            returnArray.append(matrix[0][firstArrayCounter])
        }
        
        firstArrayCounter += 1
    }
    
    return returnArray 
}

//https://www.ideserve.co.in/learn/coin-change-problem-number-of-ways-to-make-change
/*
 Given an infinite supply of coins of denominations {20,10,5,1}, find out total number of way to make change of given amount - 'n'?
 For example, if given amount is 20, there are 10 ways to make this change as shown below -
 (1 of 20),(1 of 10 + 2 of 5),(1 of 10 + 1 of 5 + 5 of 1),(1 of 10 + 10 of 1), (2 of 10), (1 of 5 + 15 of 1),(2 of 5 + 10 of 1),(3 of 5 + 5 of 1),(4 of 5),(20 of 1)

 If the amount given is 0 then the total number of ways to make change is 1 - using 0 coins of every given denomination.
 */

var countNumberOfCoinsCount = 0

func countNumberOfCoins(array: [Int], sum: Int) -> Int {
    print("First array \(array), sum \(sum)")
    var removableArray = array
    if sum == 0 {
        print("Returning 1")
        return 1
    }
    
    if sum < 0 {
        return 0
    }
    
    if array.isEmpty && sum > 0 {
        return 0
    }
    
    removableArray.removeLast()
    return countNumberOfCoins(array: removableArray, sum: sum) + countNumberOfCoins(array: array, sum: sum - array[array.count - 1])
}

func countNumberOfCoinsOtherWay(array: [Int], sum: Int, coin: Int) -> Int {
    print("First array \(array), sum \(sum)")
    countNumberOfCoinsCount += 1
    print("Printing count = countNumberOfCoinsOtherWay \(countNumberOfCoinsCount)")
    if sum == 0 {
        print("Returning 1")
        return 1
    }
    
    if sum < 0 {
        return 0
    }
    
    if array.isEmpty && sum > 0 {
        return 0
    }
    
    var noOfCombos = 0
    for i in coin...array.count-1 {
        noOfCombos += countNumberOfCoinsOtherWay(array: array, sum: sum - array[i], coin: i)
    }
    
    return noOfCombos
}

func dpCountNumberOfCoins(array: [Int], sum: Int) -> Int {
    
    let dummyArray = Array<Int>.init(repeating: 0, count: sum + 1)
    
    var matrixTable = [[Int]].init(repeating: dummyArray, count: array.count)
    
    
    
    for i in array.enumerated() {
        matrixTable[i.offset][0] = 1
    }
    
    for i in 0..<array.count {
        for j in 1...sum {
            
            if array[i] > j {
                matrixTable[i][j] = i - 1 >= 0 ? matrixTable[i - 1][j]: 0
            } else {
                let x = j - array[i] >= 0 ? matrixTable[i][j - array[i]]: 0
                let y = i >= 1 ? matrixTable[i-1][j]: 0
                
                matrixTable[i][j] = x + y
            }
        }
    }
    
    return matrixTable.last?.last ?? 0
}

//https://www.ideserve.co.in/learn/minimum-number-of-coins-to-make-change
//Given an infinite supply of coins of values: {C1, C2, ..., Cn} and a sum. Find minimum number of coins that can represent the sum.

func minimumNoOfCoinsRecursion(array: [Int], sum: Int) -> Int {
    if sum == 0 {
        return 0
    }
    
    var min = Int.max
    for i in array.enumerated() {
        if i.element <= sum {
            let value = minimumNoOfCoinsRecursion(array: array, sum: sum - i.element)
            
            if (value + 1) < min && value != Int.max {
                min = value + 1
            }
        }
    }
    
    return min
}
