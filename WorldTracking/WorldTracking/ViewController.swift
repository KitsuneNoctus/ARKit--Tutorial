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
        sceneView.debugOptions = [ARSCNDebugOptions.showWorldOrigin]
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
            if node.name == "Sphere"{
                node.removeFromParentNode()
            }
        }
        sceneView.session.run(configuration, options: [.resetTracking])
    }
    @IBAction func addButtonPress(_ sender: UIButton) {
        showShape()
    }
    
    func showShape(){
        let node = SCNNode()
        node.geometry = SCNSphere(radius: 0.05)
//        node.geometry?.firstMaterial?.diffuse.contents = UIColor.yellow
        node.geometry?.firstMaterial?.diffuse.contents = UIColor(displayP3Red: CGFloat(Xslider.value)*100, green: CGFloat(Yslider.value)*100, blue: CGFloat(Zslider.value)*100, alpha: 1)
        node.position = SCNVector3(Xslider.value,Yslider.value,Zslider.value)
        node.name = "Sphere"
        sceneView.scene.rootNode.addChildNode(node)
    }
    
    
}

