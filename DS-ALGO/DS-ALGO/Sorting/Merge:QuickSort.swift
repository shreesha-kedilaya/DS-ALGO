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
    class func quickSort<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        
        quickSort(array: &mutableArray, isOrderedBefore, low: 0, high: mutableArray.count - 1)
        
        return mutableArray
    }
    
    private class func quickSort<T: Comparable>(array: inout [T], _ isOrderedBefore: (T, T) -> Bool, low: Int, high: Int) {
        guard low < high else { return }

        let pivot = lomutoPartition(array: &array, low: low, high: high, isOrderedBefore)
        
        quickSort(array: &array, isOrderedBefore, low: low, high: pivot - 1)
        quickSort(array: &array, isOrderedBefore, low: pivot + 1, high: high)
        
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
}
