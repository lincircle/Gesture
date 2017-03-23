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
    
    var knob_view: UIView!
    
    var circle_uiview: UIView!
    
    var center_of_circle: CGPoint! //圓心座標
    
    var radius: CGFloat = 0 //半徑
    
    var last_data = "無"
    
    override func viewDidLoad() {
        
        full_size = UIScreen.main.bounds.size
        
        circle_uiview = UIView(frame: CGRect(x: 25, y: full_size.height / 2, width: full_size.width - 50, height: full_size.width - 50))
        
        circle_uiview.backgroundColor = UIColor.darkGray
        
        circle_uiview.layer.cornerRadius = circle_uiview.frame.size.width/2
        
        circle_uiview.clipsToBounds = true
        
        radius = (full_size.width - 50) / 2
        
        print("半徑: \(radius)")
        
        center_of_circle = CGPoint(x: 25 + radius, y: (full_size.height / 2) + radius)
        
        print("圓心： \(center_of_circle.x) ,\(center_of_circle.y)")
        
        self.view.addSubview(circle_uiview)
        // 方向搖桿
        knob_view = UIView(frame: CGRect(x: center_of_circle.x, y: center_of_circle.y, width: 100, height: 100))
        
        knob_view.backgroundColor = UIColor.red
        
        knob_view.layer.cornerRadius = knob_view.frame.size.width/2
        
        circle_uiview.clipsToBounds = true
        
        self.view.addSubview(knob_view)
        
        let pan = UIPanGestureRecognizer(target: self, action: #selector(ViewController.pan))
        
        pan.minimumNumberOfTouches = 1
        
        pan.maximumNumberOfTouches = 1
        
        knob_view.addGestureRecognizer(pan)
        
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
        
        let current_position = recognizer.location(in: self.view)
        
        print(current_position)
        
        let distance = distanceBetweenPoints(p1: center_of_circle, p2: current_position)
        
        print("距離為：\(distance)")
        
        //當手指距離已超出範圍，就不在更新搖桿畫面
        
        if distance <= radius {
            
            print("手指距離在範圍內")
            
            knob_view.center = current_position
            
        }
        else {
            
            print("手指距離不在範圍內")
            
            
            
            
        }
        
        if recognizer.state == UIGestureRecognizerState.ended {
            
            knob_view.center = center_of_circle
            
            print("資料傳輸為 0")
            
        }
        
        let _angle = angle(point: current_position)
        
        print("角度為：\(angle(point: current_position))")
        
        var write_date = ""
        
        switch _angle {
            
        case 135...180, (-180)..<(-135) :
            
            write_date = "前進"
            
        case 46..<136 :
            
            write_date = "右"
            
        case (-45)..<46 :
            
            write_date = "後退"
            
        case (-135)...(-46) :
            
            write_date = "左"
            
        default :
            
            print("此角度不在範圍")
            
        }
        
        if last_data != write_date {
            
            print("改變方向 ------------------------ ")
            
            print("-->\(write_date)")
            
        }
        
        last_data = write_date
        
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
    
    //算角度
    
    func angle(point: CGPoint) -> CGFloat {
        
        let originX = center_of_circle.x
        
        let originY = center_of_circle.y
        
        let a = point.x - originX
        
        let b = point.y - originY
        
        let atanA = atan2(a,b)
        
        return (atanA) * 180 / CGFloat(M_PI)
        
    }
    
}

