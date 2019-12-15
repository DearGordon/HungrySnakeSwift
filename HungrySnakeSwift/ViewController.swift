//
//  ViewController.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SnakeViewDelegate {
    
    var time:Timer?
    var snakeView:SnakeView?
    var snake:Snake?
    var fruit:Point?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSnakeView()
        addSwipeGestureRecognizer()
    }
    
    @IBOutlet weak var startBtn: UIButton!
    @IBAction func start(_ sender: Any) {
        self.startGame()
    }
    
    
    func addSnakeView(){
        self.snakeView = SnakeView(frame: self.view.frame)
        guard let snakeView = snakeView else { return }
        
        snakeView.delegate = self
        self.view.insertSubview(snakeView, at: 0)
    }
    
    func addSwipeGestureRecognizer(){
        for direction in [UISwipeGestureRecognizer.Direction.up,
            UISwipeGestureRecognizer.Direction.down,
            UISwipeGestureRecognizer.Direction.left,
            UISwipeGestureRecognizer.Direction.right]{
                let gr = UISwipeGestureRecognizer(target: self, action: #selector(swipe))
                gr.direction = direction
                self.view.addGestureRecognizer(gr)
        }
    }
    
    @objc func swipe(_ gr:UISwipeGestureRecognizer){
        let direction = gr.direction
        switch direction {
        case UISwipeGestureRecognizer.Direction.up:
            if (self.snake?.changeDirection(newDirection: Direction.up) != nil) {
                snake?.lockDirection()
            }
        case UISwipeGestureRecognizer.Direction.down:
            if (self.snake?.changeDirection(newDirection: Direction.down) != nil) {
                snake?.lockDirection()
            }
        case UISwipeGestureRecognizer.Direction.left:
            if (self.snake?.changeDirection(newDirection: Direction.left) != nil) {
                snake?.lockDirection()
            }
        case UISwipeGestureRecognizer.Direction.right:
            if (self.snake?.changeDirection(newDirection: Direction.right) != nil) {
                snake?.lockDirection()
            }
        default:
            print("wont go this way")
        }
    }
    
    func startGame(){
        startBtn.isHidden = true
        
        //make new snake
        let screenH = Int(self.view.frame.height)
        let screenW = Int(self.view.frame.width)
        let screendSize = ScreenSize(hight: screenH, width: screenW)
        snake = Snake(screenSize: screendSize, startlenght: 20)
        
        makeNewFruit()
        self.time = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(timeMoveOn), userInfo: nil, repeats: true)
        //把蛇跟水果畫上去
        
        self.snakeView!.setNeedsDisplay()
    }
    
    @objc func timeMoveOn(){
        self.snake?.move()
        let hitBody = self.snake?.isHitBody()
        if hitBody == true{
            self.endGame()
            return
        }
        
        let head = self.snake?.snakePointsArray[0]
        if head?.x == fruit?.x &&
            head?.y == fruit?.y{
            snake?.increaseLength(increase: 2)
            self.makeNewFruit()
        }
        self.snake?.unlockDirection()
        snakeView?.setNeedsDisplay()
    }
    
    
    func makeNewFruit(){
        var x = 0, y = 0
        let hight = Int(self.view.frame.height)
        let weidth = Int(self.view.frame.width)
        
        while true {
            x = (Int.random(in: 0...weidth)/10)*10
            y = (Int.random(in: 0...hight)/10)*10
            var isBody = false
            for p in self.snake!.snakePointsArray{
                if p.x==x && p.y==y{
                    isBody = true
                    break
                }
            }
            if !isBody{break}
        }
        print("x=\(x),y=\(y)")
        self.fruit = Point(x: x, y: y)
    }
    
    func endGame(){
        startBtn.isHidden = false
        self.time!.invalidate()
        self.time = nil
    }
    
    func snakeInView(whichView: SnakeView)->Snake? {
        return self.snake
    }
    
    func fruitInView(whichView: SnakeView)->Point? {
        return self.fruit
    }
}

