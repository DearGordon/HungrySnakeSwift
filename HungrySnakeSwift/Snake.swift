//
//  Snake.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

struct WorldSize {
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
    
    func newHead(oldHead:Point,worldSize:WorldSize)->(Point){
        var theX=oldHead.x
        var theY=oldHead.y
        switch self {
        case .down:
            theY+=1
            if theY>worldSize.hight! {
                theY=0
            }
        case .up:
            theY-=1
            if theY<0 {
                theY=worldSize.hight! - 1
            }
        case .left:
            theX -= 1
            if theX<0 {
                theX=worldSize.width! - 1
            }
        case .right:
            theX+=1
            if theX>worldSize.width! {
                theX=0
            }
        }
        return Point(x: theX, y: theY)
    }
}

class Snake {
    var pointsArray:Array<Point> = []
    var length:Int
    var direction:Direction = .left
    var directionLocked:Bool = false
    var worldSize:WorldSize
    
    init(worldSize:WorldSize,startlenght:Int) {
        self.worldSize = worldSize
        self.length = startlenght
        
        let x = (self.worldSize.hight!)/2
        let y = (self.worldSize.width!)/2
        //最一開始的蛇初始化
        for i in 0...length{
            let p:Point = Point(x: x+i, y: y)
            pointsArray.append(p)
        }
    }
    
    func move(){
        self.pointsArray.removeLast()
        let newHead = self.direction.newHead(oldHead: pointsArray[0], worldSize: worldSize)
        self.pointsArray.insert(newHead, at: 0)
        
    }
    
    func changeDirection(newDirection:Direction){
        if self.directionLocked{return}
        if self.direction.checkDirection(newDirection: newDirection) {
            self.direction = newDirection
        }
    }
    
    func increaseLength(){
        
    }
    
    func isHitBody(){
        
    }
    
    
    
}