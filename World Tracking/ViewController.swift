//
//  ViewController.swift
//  World Tracking
//
//  Created by Willie Johnson on 9/16/18.
//  Copyright © 2018 Willie Johnson. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
  @IBOutlet weak var sceneView: ARSCNView!

  let configuration = ARWorldTrackingConfiguration()
  override func viewDidLoad() {
    super.viewDidLoad()
    sceneView.session.run(configuration)
    sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
    sceneView.autoenablesDefaultLighting = true
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }

  @IBAction func add(_ sender: Any) {
    let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
    let node = SCNNode()
    let boxNode = SCNNode()

    doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown
    doorNode.position = SCNVector3(0, -0.02, 0.053)

    node.geometry = SCNPyramid(width: 0.1, height: 0.1, length: 0.1)
    node.position = SCNVector3(0.2, 0.3, -0.2)
    node.geometry?.firstMaterial?.specular.contents = UIColor.orange
    node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue

    boxNode.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
    boxNode.position = SCNVector3(0, -0.05, 0)
    boxNode.geometry?.firstMaterial?.specular.contents = UIColor.blue
    boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange


    sceneView.scene.rootNode.addChildNode(node)
    node.addChildNode(boxNode)
    boxNode.addChildNode(doorNode)
  }

  @IBAction func reset(_ sender: Any) {
    restartSession()
  }

  func restartSession() {
    sceneView.session.pause()
    sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
      node.removeFromParentNode()
    }

    sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
  }

  func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat {
    let rand = CGFloat(arc4random()) / CGFloat(UINT32_MAX)
    let range = abs(firstNum - secondNum) + min(firstNum, secondNum)
    return rand * range
  }
}

