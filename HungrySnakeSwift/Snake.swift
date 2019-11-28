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
    
    func move(oldHead:Point,worldSize:WorldSize)->(Point){
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
    var pointsArray:Array<Point> = []
    var length:Int
    var direction:Direction = .left
    var directionLocked:Bool = false
    var worldSize:WorldSize
    
    init(worldSize:WorldSize,startlenght:Int) {
        self.worldSize = worldSize
        self.length = startlenght
        //蛇的位置在畫面的正中央(高跟寬除2)
        let centerx = Int((self.worldSize.width!)/2/10)*10
        let centery = Int((self.worldSize.hight!)/2/10)*10
        //最一開始的蛇初始化
        for i in 0...length{
            let p:Point = Point(x: centerx + i*10, y: centery)
            pointsArray.append(p)
        }
    }
    
    func move(){
        self.pointsArray.removeLast()
        let newHead = self.direction.move(oldHead: pointsArray[0], worldSize: worldSize)
        self.pointsArray.insert(newHead, at: 0)
    }
    
    func changeDirection(newDirection:Direction){
        if self.directionLocked{return}
        if self.direction.checkDirection(newDirection: newDirection) {
            self.direction = newDirection
        }
    }
    
    //從尾巴增加點點
    func increaseLength(increase:Int){
        let lastPoint = pointsArray[pointsArray.count-1]
        let secondLastPoint = pointsArray[pointsArray.count-2]
        //判斷生成方向
        let x = lastPoint.x - secondLastPoint.x
        let y =  lastPoint.y - secondLastPoint.y
        for i in 1..<increase-1{
            let x:Int = lastPoint.x + x * i
            let y:Int = lastPoint.y + y * i
            pointsArray.append(Point(x: x, y: y))
        }
        
    }
    
    func isHitBody()->Bool{
        let headPoint = self.pointsArray[0]
//        print("headpoint=\(headPoint)")
//        print("pointArray=\(pointsArray[0])")
        for bodyPoint in pointsArray[1..<pointsArray.count-1]{
            if (headPoint.x == bodyPoint.x
                && headPoint.y == bodyPoint.y){
                print("蛇的身體=\(bodyPoint)")
                print("蛇的頭=\(headPoint)")
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
//
