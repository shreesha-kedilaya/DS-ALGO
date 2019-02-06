//
//  ViewController.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 29/01/19.
//  Copyright © 2019 Shreesha Kedlaya. All rights reserved.
//

import UIKit

class TestingViewController: UIViewController {

//    var array = [2,3,5,6,1,2,12,14,7,9,55,22]
    var array = [14,1,12,3,7,10,55]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction private func testClicked(_ sender: UIButton) {
        initialize()
    }
    
    private func initialize() {
        print("Selection Sort")
//        print(BasicSorting.selectionSort(array: array, <))
//        print("Insertion Sort")
//        print(BasicSorting.insertionSort(array: array, <))
//        print("Buuble Sort")
//        print(BasicSorting.bubbleSort(array: array, <))
//        print("Merge Sort")
//        print(AdvancedSorting.mergeSort(array: array, <))
        print("Hoares quick sorting")
        print(AdvancedSorting.quickSortHoare(array: array, <))
        print("\n\n\n")
//        print(AdvancedSorting.mergeSort(array: array, <))
    }
}
