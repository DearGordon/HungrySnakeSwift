//
//  SnakeView.swift
//  HungrySnakeSwift
//
//  Created by Kuan-Chieh Feng on 2019/11/18.
//  Copyright © 2019 Kuan-Chieh Feng. All rights reserved.
//

import UIKit

protocol SnakeViewDelegate {
    func snakeInView()->SnakeView?
    func fruitInView()->Point?
}



class SnakeView: UIView {
    var delegate:SnakeViewDelegate?
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.backgroundColor = UIColor.red
        
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
    }
    
    
    
    
}
