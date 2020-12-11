//
//  ViewController.swift
//  WorldTracking
//
//  Created by Henry Calderon on 12/10/20.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var Xslider: UISlider!
    @IBOutlet weak var Yslider: UISlider!
    @IBOutlet weak var Zslider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.showsStatistics = true
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin, ARSCNDebugOptions.showFeaturePoints]
        showShape()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        sceneView.session.run(configuration)
    }
    
    //MARK: Action
    @IBAction func resetButtonPress(_ sender: UIButton) {
        sceneView.session.pause()
        sceneView.scene.rootNode.enumerateChildNodes{ (node, _) in
            if node.name == "Shape"{
                node.removeFromParentNode()
            }
        }
        sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    @IBAction func addButtonPress(_ sender: UIButton) {
        showShape()
    }
    
    func showShape(){
        //Look in the OLD STUFF section to see the original function
        
        let plane = UIBezierPath()
        plane.move(to: CGPoint(x: 0, y: 0))
        plane.addLine(to: CGPoint(x: 0.1, y: 0.1))
        plane.addLine(to: CGPoint(x: 0.1, y: -0.03))
        let customShape = SCNShape(path: plane, extrusionDepth: 0.1)
        
        let node = SCNNode()
        node.geometry = customShape
        node.position = SCNVector3(Xslider.value,Yslider.value,Zslider.value)
        node.name = "Shape"
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    
}


//MARK: OLD STUFF
//func showShape(){
//    let text = SCNText(string: "Hello", extrusionDepth: 1)
//
//    let sphere = SCNSphere(radius: 0.05)
//    let material = SCNMaterial()
////        material.diffuse.contents = UIColor.orange
//    material.diffuse.contents = UIImage(named: "texture.jpg")
//    material.transparency = 0.6
////        text.materials = [material]
//    sphere.materials = [material]
//
//    let node = SCNNode()
//    node.geometry = SCNSphere(radius: 0.05)
////        node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0.5)
////        node.geometry = SCNTorus(ringRadius: 0.2, pipeRadius: 0.05)
////        node.geometry = SCNTube(innerRadius: 0.08, outerRadius: 0.1, height: 0.2)
////        node.geometry = SCNCapsule(capRadius: 0.06, height: 0.4)
////        node.geometry = SCNCylinder(radius: 0.04, height: 0.3)
////        node.geometry = SCNCone(topRadius: 0, bottomRadius: 0.05, height: 0.2)
////        node.geometry = SCNPyramid(width: 0.2, height:0.4, length: 0.2)
////        node.geometry = SCNPlane(width: 0.2, height: 0.3)
//
////        node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
//    node.geometry?.firstMaterial?.diffuse.contents = UIColor(displayP3Red: CGFloat(Xslider.value)*100, green: CGFloat(Yslider.value)*100, blue: CGFloat(Zslider.value)*100, alpha: 1)
//    //        node.geometry?.firstMaterial?.diffuse.contents = UIColor.purple
//    ///This (the 2 lines below) is for the text stuff
////        node.scale = SCNVector3(0.01, 0.01, 0.01)
////        node.geometry = text
//    node.geometry = sphere
//    node.position = SCNVector3(Xslider.value,Yslider.value,Zslider.value)
//    node.name = "Shape"
//    sceneView.scene.rootNode.addChildNode(node)
//}
