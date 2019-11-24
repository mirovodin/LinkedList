//
//  LinkedListTests.swift
// 
//  Created by d.mirovodin on 24.09.2019.
//  Copyright © 2019 Dmitry.Mirovodin. All rights reserved.
//

fileprivate final class LinkedListNode<T> {
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    
    init(value: T) {
        self.value = value
    }
}

public class LinkedList<T> {
    
    private typealias Node = LinkedListNode<T>
    private var head: Node?
    private var last: Node?
    private(set) public var count = 0
    
    public var isEmpty: Bool {
        return count == 0
    }
    
    init() {}

    convenience init<S: Sequence>(_ elements: S) where S.Iterator.Element == T {
        self.init()
        for element in elements {
            append(element)
        }
    }
    
    func append(_ value: T) {
        let previousLast = last
        last = Node(value: value)
        last?.previous = previousLast
        previousLast?.next = last
        if isEmpty {
           head = last
        }
        count += 1
    }
        
    func removeAll() {
        head = nil
        last = nil
        count = 0
    }

    subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    @discardableResult func removeLast() -> T {
        assert(!isEmpty)
        return remove(node: last!)
    }
    
    @discardableResult func removeFirst() -> T {
        assert(!isEmpty)
        return remove(node: head!)
    }
    
    @discardableResult func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node: node)
    }
    
    // MARK: - Private methods
    private func node(at index: Int) -> Node {
        assert(head != nil, "List is empty")
        assert(index >= 0, "index must be greater or equal to 0")
        
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            
            assert(node != nil, "index is out of bounds.")
            return node!
        }
    }
        
    @discardableResult private func remove(node: Node) -> T {
        let nextNode = node.next
        let previousNode = node.previous

        if node === head && node === last {
            head = nil
            last = nil
        } else if node === head {
            head = node.next
        } else if node === last {
            last = node.previous
        }

        previousNode?.next = nextNode
        nextNode?.previous = previousNode

        node.next = nil
        node.previous = nil
        count -= 1
        return node.value
    }
}

extension LinkedList: Equatable where T: Equatable {
    
    public static func == (lhs: LinkedList<T>, rhs: LinkedList<T>) -> Bool {
        return lhs.count == rhs.count && zip(lhs, rhs).allSatisfy { (arg) -> Bool in
            return arg.0 == arg.1
        }
    }
}

extension LinkedList: CustomStringConvertible {

    public var description: String {
        var str = "["
        forEach { (value) in
            if str.count > 1 { str += ", " }
            str += "\(value)"
        }
        return str + "]"
    }
}

extension LinkedList: Collection {
    
    public typealias Index = LinkedListIndex<T>
    
    public var startIndex: Index {
        return LinkedListIndex<T>(node: head, tag: 0)
    }
    
    public var endIndex: Index {
        return LinkedListIndex<T>(node: last, tag: count)
    }
    
    public subscript(position: Index) -> T {
        return position.node!.value
    }
        
    public func index(after idx: Index) -> Index {
        return LinkedListIndex<T>(node: idx.node?.next, tag: idx.tag + 1)
    }
}

public struct LinkedListIndex<T>: Comparable {
    fileprivate let node: LinkedListNode<T>?
    let tag: Int
    
    public static func==<T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
    
    public static func<<T>(lhs: LinkedListIndex<T>, rhs: LinkedListIndex<T>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
}
