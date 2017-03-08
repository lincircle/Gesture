//
//  ViewController.swift
//  Gesture
//
//  Created by Yuhsuan on 15/01/2017.
//  Copyright © 2017 cgua. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var full_size: CGSize!
    
    var my_uiview: UIView!
    
    var another_uiview: UIView!
    
    var circle_uiview: UIView!
    
    var big_circle_point: CGPoint!
    
    var radius:CGFloat = 0
    
    override func viewDidLoad() {
        
        full_size = UIScreen.main.bounds.size
        // 底
        circle_uiview = UIView(frame: CGRect(x: 25, y: full_size.height / 2, width: full_size.width - 50, height: full_size.width - 50))
        
        circle_uiview.backgroundColor = UIColor.brown
        
        circle_uiview.layer.cornerRadius = circle_uiview.frame.size.width/2
        
        circle_uiview.clipsToBounds = true
        
        radius = (full_size.width - 50) / 2
        
        print("radius:\(radius)")
        
        big_circle_point = CGPoint(x: 25, y: full_size.height / 2)
        
        print(big_circle_point)
        
        self.view.addSubview(circle_uiview)
        // 控制器
        another_uiview = UIView(frame: CGRect(x: full_size.width / 2 - 50, y: full_size.height * 0.75, width: 100, height: 100))
        
        another_uiview.backgroundColor = UIColor.red
        
        another_uiview.layer.cornerRadius = another_uiview.frame.size.width/2
        
        circle_uiview.clipsToBounds = true
        
        self.view.addSubview(another_uiview)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan))
        
        pan.minimumNumberOfTouches = 1
        
        pan.maximumNumberOfTouches = 1
        
        another_uiview.addGestureRecognizer(pan)
        
    }

    func pan(recognizer: UIPanGestureRecognizer){
        
        switch recognizer.state {
            
        case .began :
            
            print("began")
            
        case .cancelled :
            
            print("cancelled")
            
        case .changed :
            
            print("changed")
            
        case .ended :
            
            print("ended")
            
        case .failed:
            
            print("failed")
            
        case .possible :
            
            print("possible")
            
        }
        
        let point = recognizer.location(in: self.view)
        
        print(point)
        
        another_uiview.center = point
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            another_uiview.center = CGPoint(x: 300, y: 500)
            
        }
        
    }
    //計算距離
    func distanceBetweenPoints(p1: CGPoint, p2: CGPoint) -> CGFloat {
        
        let dx = p1.x - p2.x
        
        let dy = p1.y - p2.y
        
        return sqrt((dx * dx) + (dy * dy))
        
    }
    
    let p1 = CGPoint(x: 10, y: 10)
    
    let p2 = CGPoint(x: 10, y: 5)
    
    override func viewDidAppear(_ animated: Bool) {
        
        print(distanceBetweenPoints(p1: p1, p2: p2))
        
    }
    
}

