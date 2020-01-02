//
//  Snake.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

struct ScreenSize {
    var hight:Int?
    var width:Int?
}

struct Point {
    var x:Int
    var y:Int
}

enum Direction{
    case up
    case down
    case left
    case right
    
    func checkDirection(newDirection:Direction)->Bool{
        var isOK = false
        switch self {
        case .left,.right:
            isOK = newDirection == .up || newDirection == .down
        case .up,.down:
            isOK = newDirection == .right || newDirection == .left
        }
        
        return isOK
    }
    
    func move(oldHead:Point,worldSize:ScreenSize)->(Point){
        var theX=oldHead.x
        var theY=oldHead.y
        switch self {
        case .down:
            theY+=10
            if theY>worldSize.hight! {
                theY=0
            }
        case .up:
            theY-=10
            if theY<0 {
                theY=Int(worldSize.hight!/10)*10 - 10
            }
        case .left:
            theX -= 10
            if theX<0 {
                theX=Int(worldSize.width!/10)*10 - 10
            }
        case .right:
            theX+=10
            if theX>worldSize.width! {
                theX=0
            }
        }
        return Point(x: theX, y: theY)
    }
}

class Snake {
    var snakePointsArray:Array<Point> = []
    var length:Int
    var direction:Direction = .left
    var directionLocked:Bool = false
    var screenSize:ScreenSize
    
    init(screenSize:ScreenSize,startlenght:Int) {
        self.screenSize = screenSize
        self.length = startlenght
        
        let centerX = Int((self.screenSize.width!)/2/10)*10
        let centerY = Int((self.screenSize.hight!)/2/10)*10
        
        for i in 0...length{
            let snakePoint:Point = Point(x: centerX + i*10, y: centerY)
            snakePointsArray.append(snakePoint)
        }
    }
    
    func move(){
        self.snakePointsArray.removeLast()
        let newHead = self.direction.move(oldHead: snakePointsArray[0], worldSize: screenSize)
        self.snakePointsArray.insert(newHead, at: 0)
    }
    
    func changeDirection(newDirection:Direction){
        if self.directionLocked { return }
        if self.direction.checkDirection(newDirection: newDirection) {
            self.direction = newDirection
        }
    }
    
    //add point at tail
    func increaseLength(increase:Int){
        let lastPoint = snakePointsArray[snakePointsArray.count-1]
        let secondLastPoint = snakePointsArray[snakePointsArray.count-2]
        
        let xGroDirect = lastPoint.x - secondLastPoint.x
        let yGroDirect =  lastPoint.y - secondLastPoint.y
        
        for i in 1..<increase-1{
            let newX:Int = lastPoint.x + (xGroDirect * i)
            let newY:Int = lastPoint.y + (yGroDirect * i)
            snakePointsArray.append(Point(x: newX, y: newY))
        }
        
    }
    
    func isHitBody()->Bool{
        let headPoint = self.snakePointsArray[0]
        
        for bodyPoint in snakePointsArray[1..<snakePointsArray.count-1]{
            if (headPoint.x == bodyPoint.x
                && headPoint.y == bodyPoint.y){
                return true
            }
        }
        return false
    }
    
    func lockDirection(){
        self.directionLocked = true
    }
    
    func unlockDirection(){
        self.directionLocked = false
    }
    
    
}
