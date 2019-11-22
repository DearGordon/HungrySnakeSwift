//
//  ViewController.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

class ViewController: UIViewController,SnakeViewDelegate {
    
    
    var snakeView:SnakeView?
    var snake:Snake?
    var fruit:Point?
    
    func letsTryNewFunction(){
        print("the function is ready to go")
    }
    
    func catFunction(){
        print("where is my cat?")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //貼上snakeView
        self.snakeView = SnakeView(frame: self.view.frame)
        //如果用insertSubview就不會把storyboard的Btn蓋掉
        self.view.insertSubview(self.snakeView!, at: 0)
        
        if let view = self.snakeView{
            view.delegate = self
        }
        
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
            print("up")
        case UISwipeGestureRecognizer.Direction.down:
            print("down")
        case UISwipeGestureRecognizer.Direction.left:
            print("left")
        case UISwipeGestureRecognizer.Direction.right:
            print("right")
        default:
            print("wont go this way")
        }
    }
    
    func timeMoveOn(){
        
    }
    
    func makeNewFruit(){
        var x = 0, y = 0
        let hight = Int(self.view.frame.height)
        let weidth = Int(self.view.frame.width)
        
        while true {
            x = Int.random(in: 0...hight)
            y = Int.random(in: 0...weidth)
            var isBody = false
            for p in self.snake!.pointsArray{
                if p.x==x && p.y==y{
                    isBody = true
                    break
                }
            }
            if !isBody{break}
        }
        print("x=\(x),y=\(y)")
    }
    
    func startGame(){
//        startBtn.isHidden = true
        makeNewFruit()
        //make new fruit
        //make new snake
        
    }
    
    func endGame(){
        startBtn.isHidden = false
    }
    
    @IBOutlet weak var startBtn: UIButton!
    @IBAction func start(_ sender: Any) {
        self.startGame()
    }
    
    
    
    func snakeInView()->Snake? {
        return self.snake
    }
    
    func fruitInView()->Point? {
        return self.fruit
    }
}

