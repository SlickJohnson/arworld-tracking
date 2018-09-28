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
    addHouse()
    addFace()
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

extension Int {
  var degreesToRadians: Double { return Double(self) * .pi / 180 }
}

extension Double {
  var float: Float { return Float(self) }
}

extension ViewController {
  func addHouse() {
    let houseNode = SCNNode(geometry: SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0))
    let doorNode = SCNNode(geometry: SCNPlane(width: 0.03, height: 0.06))
    let roofNode = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))

    houseNode.position = SCNVector3(0, -0.05, 0)
    houseNode.geometry?.firstMaterial?.specular.contents = UIColor.blue
    houseNode.geometry?.firstMaterial?.diffuse.contents = UIColor.orange

    doorNode.position = SCNVector3(0, -0.02, 0.053)
    doorNode.geometry?.firstMaterial?.diffuse.contents = UIColor.brown

    roofNode.position = SCNVector3(0, 0.3, -0.2)
    roofNode.geometry?.firstMaterial?.specular.contents = UIColor.orange
    roofNode.geometry?.firstMaterial?.diffuse.contents = UIColor.blue

    roofNode.addChildNode(houseNode)
    houseNode.addChildNode(doorNode)
    sceneView.scene.rootNode.addChildNode(roofNode)
  }

  func addFace() {
    let cylinder = SCNNode(geometry: SCNCylinder(radius: 0.1, height: 0.15))
    cylinder.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    cylinder.position = SCNVector3(0, 0, -0.2)
    cylinder.eulerAngles = SCNVector3(0, 0, 90.degreesToRadians.float)

    let pyramid = SCNNode(geometry: SCNPyramid(width: 0.1, height: 0.1, length: 0.1))
    pyramid.geometry?.firstMaterial?.diffuse.contents = UIColor.red
    pyramid.position = SCNVector3(0, 0, 0.05)
    pyramid.eulerAngles = SCNVector3(90.degreesToRadians.float, 0, 0)

    cylinder.addChildNode(pyramid)
    sceneView.scene.rootNode.addChildNode(cylinder)
  }
}

