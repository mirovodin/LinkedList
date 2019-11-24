//
//  LinkedListTests.swift
//  LinkedListTests
//
//  Created by d.mirovodin on 24.09.2019.
//  Copyright © 2019 Dmitry.Mirovodin. All rights reserved.
//

import XCTest
@testable import LinkedList

final class LinkedListTests: XCTestCase {

    private var list: LinkedList<Int>!
    
    override func setUp() {
        super.setUp()
        list = LinkedList<Int>([1, 2, 3, 4, 5])
    }
    
    override func tearDown() {
        list = nil
        super.tearDown()
    }
    
    // MARK: - Tests
    
    func testEquatable() {
        let list2 = LinkedList([1, 2, 3, 4, 5])
        XCTAssertEqual(list, list2)
    }
    
    func testAppend() {
        list.append(6)

        XCTAssertEqual(list, LinkedList(1..<7))
        XCTAssertEqual(list.count, 6)
    }
    
    func testNode() {
        list.append(10)

        let lastValue = list[5]
        let middleValue = list[3]

        XCTAssertEqual(lastValue, 10)
        XCTAssertEqual(middleValue, 4)
    }
    
    func testValue() {
        let value = list[3]
        XCTAssertEqual(value, 4)
    }
    
    func testRemoveStart() {
        list.remove(at: 0)

        XCTAssertEqual(list, LinkedList(2..<6))
        XCTAssertEqual(list.count, 4)
    }
    
    func testRemoveLast() {
        let node = list.removeLast()
        XCTAssertEqual(node, 5)
        XCTAssertEqual(list, LinkedList(1..<5))
        XCTAssertEqual(list.count, 4)
    }

    func testRemoveFirst() {
        let node = list.removeFirst()
        XCTAssertEqual(node, 1)
        XCTAssertEqual(list, LinkedList(2..<6))
        XCTAssertEqual(list.count, 4)
    }
    
    func testRemoveEnd() {
        list.remove(at: list.count - 1)

        XCTAssertEqual(list, LinkedList(1..<5))
        XCTAssertEqual(list.count, 4)
    }
    
    func testRemoveMiddle() {
        list.remove(at: 2)

        let list2 = LinkedList([1, 2, 4, 5])
        XCTAssertEqual(list, list2)
        XCTAssertEqual(list.count, 4)
    }

    func testRemoveEndFromTwoElementList() {
        let twoElementList = LinkedList([1, 2])
        twoElementList.remove(at: 1)

        XCTAssertEqual(twoElementList, LinkedList([1]))
    }

    func testRemoveStartFromTwoElementList() {
        let twoElementList = LinkedList([1, 2])
        twoElementList.remove(at: 0)

        XCTAssertEqual(twoElementList, LinkedList([2]))
    }

    func testRemoveFromSingleElementLsit() {
        let singleElementList = LinkedList([1])
        singleElementList.remove(at: 0)

        XCTAssertEqual(singleElementList, LinkedList())
    }

    func testRemoveAndThenAdd() {
        for _ in (1..<6) {
            list.remove(at: 0)
        }

        for i in (1..<10) {
            list.append(i)
        }

        XCTAssertEqual(list, LinkedList((1..<10)))
    }
    
}
