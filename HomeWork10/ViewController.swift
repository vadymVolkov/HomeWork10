//
//  ViewController.swift
//  HomeWork10
//
//  Created by Vadym Volkov on 10.06.2020.
//  Copyright © 2020 Vadym Volkov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var star: UIView!
    var startCenter: CGPoint?
    @IBOutlet weak var forceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        star.isUserInteractionEnabled = true
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(pan(_:)))
        star.addGestureRecognizer(panRecognizer)
        let pinchRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(pinch(_:)))
        star.addGestureRecognizer(pinchRecognizer)
        let rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotation(_:)))
        star.addGestureRecognizer(rotationRecognizer)
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tap(_:)))
        star.addGestureRecognizer(tapRecognizer)
        let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(doubleTap(_:)))
        doubleTapRecognizer.numberOfTapsRequired = 2
        star.addGestureRecognizer(doubleTapRecognizer)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let force = touch.force/touch.maximumPossibleForce
            forceLabel.text = "\(force)% force"
        }
    }
    
    @objc func pan(_ recognizer: UIPanGestureRecognizer) {
        switch recognizer.state {
        case .began:
            if startCenter == nil {
                startCenter = star.center
            }
            break
        case .changed:
            let translation = recognizer.translation(in: view)
            star.center = CGPoint(x: star.center.x + translation.x,
                                  y: min(star.center.y + translation.y, 500))
            recognizer.setTranslation(.zero, in: view)
            break
        default:
            break
        }
    }
    
    @objc func pinch(_ recognizer: UIPinchGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.scaledBy(x: recognizer.scale, y: recognizer.scale)
            recognizer.scale = 1.0
        }
    }
    
    @objc func rotation(_ recognizer: UIRotationGestureRecognizer) {
        if let view = recognizer.view {
            view.transform = view.transform.rotated(by: recognizer.rotation)
            recognizer.rotation = 0
        }
    }
    
    @objc func tap(_ recognizer: UIRotationGestureRecognizer) {
        star.backgroundColor = .red
        
    }
    
    @objc func doubleTap(_ recognizer: UIRotationGestureRecognizer) {
        star.backgroundColor = nil
        
    }
    
   
    
}

