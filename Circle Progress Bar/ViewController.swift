//
//  ViewController.swift
//  Circle Progress Bar
//
//  Created by omrobbie on 19/10/18.
//  Copyright © 2018 omrobbie. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var txtValue: UITextField!

    var shapeLayer1 = CAShapeLayer()
    var shapeLayer2 = CAShapeLayer()
    var shapeLayer3 = CAShapeLayer()

    var arcPath: CGPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.setupArc()
    }
    
    func setupArc() {
        self.arcPath = UIBezierPath(arcCenter: view.center, radius: 100, startAngle: CGFloat.pi, endAngle: 0, clockwise: true).cgPath
        
        self.shapeLayer3 = drawArc(initialPercentage: 80)
        self.shapeLayer2 = drawArc(initialPercentage: 70, color: UIColor.gray.cgColor)
        self.shapeLayer1 = drawArcGradient(initialPercentage: 40)
    }
    
    func drawArc(initialPercentage: CGFloat = 0, color: CGColor = UIColor.lightGray.cgColor) -> CAShapeLayer {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = self.arcPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color
        shapeLayer.lineCap = .round
        shapeLayer.lineWidth = 20
        shapeLayer.strokeEnd = initialPercentage / 100
        
        view.layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    func drawArcGradient(initialPercentage: CGFloat = 0, colors: [CGColor] = [UIColor.green.cgColor, UIColor.yellow.cgColor, UIColor.red.cgColor]) -> CAShapeLayer {
        let shapeLayer = drawArc(initialPercentage: initialPercentage)
        let gradientLayer = CAGradientLayer()
        
        gradientLayer.frame = view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        gradientLayer.colors = colors
        gradientLayer.mask = shapeLayer
        
        view.layer.addSublayer(gradientLayer)
        
        return shapeLayer
    }
    
    func animateArc(percentage: CGFloat, shapeLayer: CAShapeLayer) {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.duration = 1.5
        basicAnimation.fillMode = .forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.strokeEnd = CGFloat(percentage) / 100
        print(shapeLayer.strokeEnd)
        shapeLayer.add(basicAnimation, forKey: "")
    }

    @IBAction func btnAddClicked(_ sender: Any) {
        if let percentage: Float = Float(txtValue.text!) {
            animateArc(percentage: CGFloat(percentage), shapeLayer: shapeLayer1)
        }
    }
    
    @IBAction func btnResetClicked(_ sender: Any) {
        shapeLayer1.strokeEnd = 0.0
    }
}
