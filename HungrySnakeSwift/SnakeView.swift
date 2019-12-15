//
//  SnakeView.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

protocol SnakeViewDelegate {
    func snakeInView(whichView:SnakeView)->Snake?
    func fruitInView(whichView:SnakeView)->Point?
}



class SnakeView: UIView {
    var delegate:SnakeViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.black
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        UIColor.white.set()
        guard let snake:Snake = delegate?.snakeInView(whichView: self),
              let fruit:Point = delegate?.fruitInView(whichView: self) else {
                print("no snake or fruit")
                return
        }
    
        for point in snake.snakePointsArray {
            let rect = CGRect(x: Int(point.x/10)*10, y: Int(point.y/10)*10, width:  10, height:  10)
            UIBezierPath(rect: rect).fill()
        }
        print("snakeBody=\(snake.snakePointsArray)")
        
        let rect = CGRect(x: Int(fruit.x/10)*10, y: Int(fruit.y/10)*10, width: 10, height: 10)
        UIBezierPath(ovalIn: rect).fill()
        print("fruit in snakeView=\(fruit)")
        
    }
    
    
}
