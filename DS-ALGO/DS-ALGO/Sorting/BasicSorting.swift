//
//  BasicSorting.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 29/01/19.
//  Copyright © 2019 Shreesha Kedlaya. All rights reserved.
//

import Foundation

class BasicSorting {
    
    // MARK: Bubble sort
    class func bubbleSort<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        for i in 0...mutableArray.count - 1 {
            for j in 0..<mutableArray.count - i - 1 {
                if isOrderedBefore(mutableArray[j+1], mutableArray[j]) {
//                    (mutableArray[j], mutableArray[j+1]) = (mutableArray[j+1], mutableArray[j])
                    mutableArray.swapAt(j, j+1)
                }
            }
        }
        
        return mutableArray
    }
    
    // MARK: Insertion sort.
    class func insertionSort<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        
        for i in 1..<mutableArray.count {
            var j = i
            
            let temp = mutableArray[j]
            
            while j > 0 && isOrderedBefore(temp, mutableArray[j-1]) {
                mutableArray[j] = mutableArray[j-1]
                j -= 1
            }
            
            mutableArray[j] = temp
        }
        
        return mutableArray
    }
    
    // MARK: Selection sort
    class func selectionSort<T: Comparable>(array: [T], _ isOrderedBefore: (T, T) -> Bool) -> [T] {
        var mutableArray = array
        var selectIndex = 0
        for i in 0..<mutableArray.count - 1 {
            
            selectIndex = i
            
            for j in i+1..<mutableArray.count {
                if isOrderedBefore(mutableArray[j], mutableArray[selectIndex]) {
                    selectIndex = j
                }
            }
            
            mutableArray.swapAt(i, selectIndex)
        }
        
        return mutableArray
    }
}
