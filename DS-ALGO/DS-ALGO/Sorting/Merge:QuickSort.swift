//
//  Merge:QuickSort.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 29/01/19.
//  Copyright © 2019 Shreesha Kedlaya. All rights reserved.
//

import Foundation

class AdvancedSorting {
    
    // MARK: Merge Sort
    class func mergeSort<T>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        
        guard array.count > 1 else { return array }
        
        let middleIndex = array.count / 2
        
        let leftArray = mergeSort(array: Array(array[0..<middleIndex]), isOrderedBefore)
        let rightArray = mergeSort(array: Array(array[middleIndex..<array.count]), isOrderedBefore)
        
        return merge(leftArray, rightArray, isOrderedBefore)
    }
    
    private class func merge<T>(_ left: [T], _ right: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        
        var orderedArray: [T] = []
        
        var leftIndex = 0
        var rightIndex = 0
        
        while leftIndex < left.count && rightIndex < right.count {
            
            if isOrderedBefore(right[rightIndex], left[leftIndex]) {
                orderedArray.append(right[rightIndex])
                rightIndex += 1
            } else if  isOrderedBefore(left[leftIndex], right[rightIndex]) {
                orderedArray.append(left[leftIndex])
                leftIndex += 1
            } else {
                orderedArray.append(right[rightIndex])
                orderedArray.append(left[leftIndex])
                leftIndex += 1
                rightIndex += 1
            }
        }
        
        while leftIndex < left.count {
            orderedArray.append(left[leftIndex])
            leftIndex += 1
        }
        
        while rightIndex < right.count {
            orderedArray.append(right[rightIndex])
            rightIndex += 1
        }
        
        return orderedArray
    }
    
    // MARK: Quick sort
    class func quickSortLomuto<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        
        quickSortLomuto(array: &mutableArray, isOrderedBefore, low: 0, high: mutableArray.count - 1)
        
        return mutableArray
    }
    
    class func quickSortHoare<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        
        quickSortHoares(array: &mutableArray, isOrderedBefore, low: 0, high: array.count - 1)
        
        return mutableArray
    }
    
    private class func quickSortLomuto<T: Comparable>(array: inout [T], _ isOrderedBefore: (T, T) -> Bool, low: Int, high: Int) {
        guard low < high else { return }

        let pivot = lomutoPartition(array: &array, low: low, high: high, isOrderedBefore)
        
        quickSortLomuto(array: &array, isOrderedBefore, low: low, high: pivot - 1)
        quickSortLomuto(array: &array, isOrderedBefore, low: pivot + 1, high: high)
        
    }

    private class func lomutoPartition<T: Comparable>(array: inout [T], low: Int, high: Int, _ isOrderedBefore: (T, T) -> Bool) -> Int {
        let pivot = array[high]
        
        var i = low - 1
        for j in low..<high {
            if isOrderedBefore(array[j], pivot) {
                i += 1
                array.swapAt(i, j)
            }
        }
        
        array.swapAt(i+1, high)
        
        return i + 1
    }
    
    private class func quickSortHoares<T: Comparable>(array: inout [T], _ isOrderedBefore: (T, T) -> Bool, low: Int, high: Int) {
        guard low < high else {
            return
        }
        
        let pivot = partitionHoares(array: &array, low: low, high: high, isOrderedBefore)
        
        quickSortHoares(array: &array, isOrderedBefore, low: low, high: pivot)
        quickSortHoares(array: &array, isOrderedBefore, low: low + 1, high: high)
    }
    
    private class func partitionHoares<T: Comparable>(array: inout [T], low: Int, high: Int, _ isOrderedBefore: (T, T) -> Bool) -> Int {
        let pivot = array[low]
        var i = low - 1
        var j = high + 1
        
        print("Entered here \(i) \(j)")
        while true {
            repeat {
                j -= 1
            } while array[j] > pivot
            
            repeat {
                i += 1
            } while array[i] < pivot
            
            
            if i < j {
                array.swapAt(i, j)
                
                print("printing i and j \(i) and \(j)")
                print(array)
            } else {
                print("-------------------Returning j \(j)--------------")
                return j
            }
        }
    }
}
