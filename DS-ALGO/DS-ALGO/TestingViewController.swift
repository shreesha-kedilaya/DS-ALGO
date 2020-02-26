//
//  ViewController.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 29/01/19.
//  Copyright © 2019 Shreesha Kedlaya. All rights reserved.
//

import UIKit

typealias jsonDictionary = [String: Any]
typealias jsonArray = [jsonDictionary]

class TestingViewController: UIViewController {

//    var array = [2,3,5,6,1,2,12,14,7,9,55,22]
    var array = [14,1,12,3,7,10,55]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let path = Bundle.main.path(forResource: "JsonFile", ofType: "json") {
//            let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
//            let jsonResult = try! JSONSerialization.jsonObject(with: data!, options: .mutableLeaves) as! jsonArray
//            //                if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let person = jsonResult["person"] as? [Any] {
//            // do stuff
//            
//            let string = stringify(json: jsonResult, prettyPrinted: true)
//            print(string)
//        }
        
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
//        print("Hoares quick sorting")
//        print(AdvancedSorting.quickSortHoare(array: array, <))
//        print("\n\n\n")
//        print(AdvancedSorting.mergeSort(array: array, <))
        
        print("Heaps \(Heap.init(array: [1,2,5,6,7,19,20,47], sort: <))")
    
        let bst = BinarySearchTree<Int>.init(array: [50,70,80,60,30,20,10,40])
        
        print(bst.description)
        print("Queues" )
        
//        print(bst.remove())
        print("IsBST")
        bst.traverseInOrder { (value) in
            print("Values \(value)")
        }
        print(bst.isBst(leftNode: nil, rightNode: nil))
        let queue = Queue<String>()
        
        let tree = BinarySearchTree<Int>.init(value: 50)
        let tree1 = BinarySearchTree<Int>.init(value: 90)
        let tree2 = BinarySearchTree<Int>.init(value: 80)
        let tree3 = BinarySearchTree<Int>.init(value: 70)
        
        let tree4 = BinarySearchTree<Int>.init(value: 60)
        let tree5 = BinarySearchTree<Int>.init(value: 100)
        let tree6 = BinarySearchTree<Int>.init(value: 40)
        let tree7 = BinarySearchTree<Int>.init(value: 30)
        let tree8 = BinarySearchTree<Int>.init(value: 20)
        
        
        tree.left = tree7
        tree7.parent = tree
        tree.right = tree3
        tree3.parent = tree
        
        tree7.left = tree8
        tree8.parent = tree7
        tree7.right = tree6
        tree6.parent = tree7
        
        tree3.left = tree4
        tree4.parent = tree3
        tree3.right = tree1
        tree1.parent = tree3
        
        tree1.left = tree2
        tree2.parent = tree1
        tree1.right = tree5
        tree5.parent = tree1
        
        
        print(tree.description)
        print("isbist \(tree.isBstAmature())")
//        for i in 0...100 {
//            queue.enqueue("i is \(i)")
//        }
//        
//        for _ in 0...40 {
//            let string = queue.dequeue()
//            
//            print(string)
//        }
    }
}

func stringify(json: Any, prettyPrinted: Bool = false) -> String {
    var options: JSONSerialization.WritingOptions = []
    if prettyPrinted {
        options = JSONSerialization.WritingOptions.prettyPrinted
    }
    
    do {
        let data = try JSONSerialization.data(withJSONObject: json, options: options)
        if let string = String(data: data, encoding: String.Encoding.utf8) {
            return string
        }
    } catch {
        print(error)
    }
    
    return ""
}
