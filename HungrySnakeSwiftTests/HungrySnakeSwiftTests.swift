//
//  HungrySnakeSwiftTests.swift
//  HungrySnakeSwiftTests
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import XCTest
@testable import HungrySnakeSwift



class HungrySnakeSwiftTests: XCTestCase {
    var viewController:ViewController!
    var snake:Snake!
    var snakeView:SnakeView!
    let screenSize:ScreenSize = ScreenSize(hight: 667, width: 375)

    override func setUp() {
        super.setUp()
        snake = Snake(screenSize: screenSize, startlenght: 20)
        
    }
    
    func testHitBody(){
        snake.move()
        snake.changeDirection(newDirection: .up)
        snake.move()
        snake.changeDirection(newDirection: .left)
        snake.move()
        snake.changeDirection(newDirection: .down)
        snake.move()
        snake.changeDirection(newDirection: .right)
        snake.move()
        
        XCTAssert(snake.isHitBody())
    }
    
    func testMove(){
        snake.move()
        let head = snake.snakePointsArray.first
        XCTAssertEqual(head?.x, 170)
        XCTAssertEqual(head?.y, 330)
    }
    
    func testChangeDirection(){
        snake.move()
        snake.changeDirection(newDirection:.up)
        snake.move()
        let head = snake.snakePointsArray.first
        XCTAssertEqual(head?.x, 170)
        XCTAssertEqual(head?.y, 320)
    }
    
    func testIncreaseLength(){
        snake.increaseLength(increase: 2)
        
        let tail:Array<Point> = snake.snakePointsArray
        XCTAssertEqual(tail.last?.x, 380)
        XCTAssertEqual(tail.last?.y, 330)

    }
   
}
