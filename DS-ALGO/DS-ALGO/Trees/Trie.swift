//
//  Trie.swift
//  DS-ALGO
//
//  Created by Shreesha Kedlaya on 26/02/20.
//  Copyright © 2020 Shreesha Kedlaya. All rights reserved.
//

import Foundation

class TrieNode<T: Hashable> {
    var value: T?
    var parent: TrieNode<T>?
    
    var children: [T: TrieNode<T>] = [:]
    var isTerminating = false
    var isLeaf: Bool {
        return children.count == 0
    }
    
    init(value: T? = nil, parentNode: TrieNode<T>? = nil) {
        self.value = value
        self.parent = parentNode
    }
    
    func add(value: T) {
        guard children[value] == nil else {
            return
        }
        
        children[value] = TrieNode(value: value, parentNode: self)
    }
}

class Trie {
    typealias Node = TrieNode<Character>
    var root: Node
    var wordCount = 0
    
    init(word: String) {
        root = Node()
        self.insert(word: word)
    }
    
    func insert(word: String) {
        guard !word.isEmpty else {
            return
        }
        var currentNode = root
        for character in word.lowercased() {
            if let childNode = currentNode.children[character] {
                currentNode = childNode
            } else {
                currentNode.add(value: character)
                currentNode = currentNode.children[character]!
            }
        }
        
        // This is for a word which is already present in the trie
        guard !currentNode.isTerminating else {
            return
        }
        
        currentNode.isTerminating = true
        wordCount += 1
    }
    
    func contains(word: String) -> Bool {
        guard !word.isEmpty else {
            return false
        }
        var currentNode = root
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return false
            }
            currentNode = childNode
        }
        return currentNode.isTerminating
    }
    
    func findLastNodeOf(word: String) -> Node? {
        guard !word.isEmpty else {
            return nil
        }
        var currentNode = root
        for character in word.lowercased() {
            guard let childNode = currentNode.children[character] else {
                return nil
            }
            currentNode = childNode
        }
        return currentNode
    }
    
    func findTerminalNodeOf(word: String) -> Node? {
        if let lastNode = findLastNodeOf(word: word) {
            return lastNode.isTerminating ? lastNode : nil
        }
        return nil
    }
    
    private func deleteNodesForWordEndingWith(terminalNode: Node) {
        var lastNode = terminalNode
        var character = lastNode.value
        while lastNode.isLeaf, let parentNode = lastNode.parent {
            lastNode = parentNode
            lastNode.children[character!] = nil
            character = lastNode.value
            if lastNode.isTerminating {
                break
            }
        }
    }
    
    func remove(word: String) {
        guard !word.isEmpty else {
            return
        }
        guard let terminalNode = findTerminalNodeOf(word: word) else {
            return
        }
        if terminalNode.isLeaf {
            deleteNodesForWordEndingWith(terminalNode: terminalNode)
        } else {
            terminalNode.isTerminating = false
        }
        wordCount -= 1
    }
    
    func getWords(node: Node, appendWord: String) -> [String] {
        var array = [String]()
        var pl = appendWord
        if let value = node.value {
            pl.append(value)
        }
        for child in node.children.values {
            let childWords = getWords(node: child, appendWord: pl)
            array += childWords
        }
        
        if node.isTerminating {
            return [pl]
        }
        
        return array
    }
    
    func wordsInSubtrie(rootNode: Node, partialWord: String) -> [String] {
        var previousLetters = partialWord
        if let value = rootNode.value {
            previousLetters.append(value)
        }
        
        var subtrieWords = [String]()
        for childNode in rootNode.children.values {
                        
            let childWords = wordsInSubtrie(rootNode: childNode, partialWord: previousLetters)
            subtrieWords += childWords
        }

        if rootNode.isTerminating {
            return [previousLetters]
        }
        
        return subtrieWords
    }
    
    func findWordsWithPrefix(prefix: String) -> [String] {
        var words = [String]()
        let prefixLowerCased = prefix.lowercased()
        if let lastNode = findLastNodeOf(word: prefixLowerCased) {
            if lastNode.isTerminating {
                words.append(prefixLowerCased)
            }
            for childNode in lastNode.children.values {
                let childWords = wordsInSubtrie(rootNode: childNode, partialWord: prefixLowerCased)
                words += childWords
            }
        }
        return words
    }
}
