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
    
    var big_circle_point: CGPoint! //圓心座標
    
    var radius:CGFloat = 0 //半徑
    
    var last_data = "無"
    
    override func viewDidLoad() {
        
        full_size = UIScreen.main.bounds.size
        // 底
        circle_uiview = UIView(frame: CGRect(x: 25, y: full_size.height / 2, width: full_size.width - 50, height: full_size.width - 50))
        
        circle_uiview.backgroundColor = UIColor.brown
        
        circle_uiview.layer.cornerRadius = circle_uiview.frame.size.width/2
        
        circle_uiview.clipsToBounds = true
        
        radius = (full_size.width - 50) / 2
        
        print("radius:\(radius)")
        
        big_circle_point = CGPoint(x: 25 + radius, y: (full_size.height / 2) + radius)
        
        print(big_circle_point)
        
        self.view.addSubview(circle_uiview)
        // 控制器
        another_uiview = UIView(frame: CGRect(x: big_circle_point.x, y: big_circle_point.y, width: 100, height: 100))
        
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
            
            another_uiview.center = big_circle_point
            
            print("資料傳輸為 0")
            
        }
        
        print("距離為：\(distanceBetweenPoints(p1: big_circle_point, p2: point))")
        
        print("角度為：\(angle(point: point))")
        
        let p = angle(point: point)
        
        var write_date = ""
        
        switch  p {
            
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
        
        //print("-->\(write_date)")
        
        if last_data != write_date {
            
            print("現在才傳輸資料------------------------")
            
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
    
    func angleBetweenLine(lineABegin: CGPoint, lineAEnd: CGPoint, lineBBegin: CGPoint, lineBEnd: CGPoint) -> CGFloat {
        
        let a = lineAEnd.x - lineABegin.x
        
        let b = lineAEnd.y - lineABegin.y
        
        let atanA = atan2(a,b)
    
        let c = lineBEnd.x - lineBBegin.x
        
        let d = lineBEnd.y - lineBBegin.y
        
        let atanB = atan2(c,d)
        
        return (atanA - atanB) * 180 / CGFloat(M_PI)
 
    }
    
    func angle(point: CGPoint) -> CGFloat {
        
        let originX = big_circle_point.x
        
        let originY = big_circle_point.y
        
        let a = point.x - originX
        
        let b = point.y - originY
        
        let atanA = atan2(a,b)
        
        return (atanA) * 180 / CGFloat(M_PI)
        
    }
    
}

