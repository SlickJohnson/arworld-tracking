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
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


  @IBAction func add(_ sender: Any) {
    let node = SCNNode()
    node.geometry = SCNBox(width: 0.1, height: 0.1, length: 0.1, chamferRadius: 0)
    node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
    node.position = SCNVector3(-0.3, -0.2, -0.5)
    sceneView.scene.rootNode.addChildNode(node)
    print("Node added")
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
}

