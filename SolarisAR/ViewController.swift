//
//  ViewController.swift
//  SolarisAR
//
//  Created by Setiawan Joddy on 12/06/20.
//  Copyright © 2020 Setiawan Joddy. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneView: ARSCNView!
    
    let spaceNode = SCNNode()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.clearScreen()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        
        let sun = createPlanet(radius: 0.3, image: "sun")
        sun.name = "sun"
        sun.position = SCNVector3(0.0, 0.0, 0.0)
        rotationEffect(rotation: 0.15, planet: sun, duration: 1)
        
        let mercuryOrbit = createOrbitPath(orbitSize: 0.55)
        let mercury = createPlanet(radius: 0.05, image: "planetMercury")
        mercury.name = "mercury"
        mercury.position = SCNVector3(0.55, 0.0, 0.0)
        rotationEffect(rotation: 0.75, planet: mercury, duration: 1)
        rotationEffect(rotation: 0.75, planet: mercuryOrbit, duration: 1)
        
        let venusOrbit = createOrbitPath(orbitSize: 1.0)
        let venus = createPlanet(radius: 0.11, image: "planetVenus")
        venus.name = "venus"
        venus.position = SCNVector3(1.0, 0.0, 0.0)
        rotationEffect(rotation: 0.6, planet: venus, duration: 1)
        rotationEffect(rotation: 0.6, planet: venusOrbit, duration: 1)
        
        let earthOrbit = createOrbitPath(orbitSize: 1.2)
        let earth = createPlanet(radius: 0.16, image: "planetEarth_day")
        earth.name = "earth"
        earth.position = SCNVector3(1.2, 0.0, 0.0)
        rotationEffect(rotation: 0.4, planet: earth, duration: 1)
        rotationEffect(rotation: 0.4, planet: earthOrbit, duration: 1)
        
        let marsOrbit = createOrbitPath(orbitSize: 1.8)
        let mars = createPlanet(radius: 0.18, image: "planetMars")
        mars.name = "mars"
        mars.position = SCNVector3(1.8, 0.0, 0.0)
        rotationEffect(rotation: 0.27, planet: mars, duration: 1)
        rotationEffect(rotation: 0.27, planet: marsOrbit, duration: 1)
        
        let jupiterOrbit = createOrbitPath(orbitSize: 2.1)
        let jupiter = createPlanet(radius: 0.32, image: "planetJupiter")
        jupiter.name = "jupiter"
        jupiter.position = SCNVector3(2.1, 0.0, 0.0)
        rotationEffect(rotation: 0.2, planet: jupiter, duration: 1)
        rotationEffect(rotation: 0.2, planet: jupiterOrbit, duration: 1)
        
        let saturnOrbit = createOrbitPath(orbitSize: 3.0)
        let saturn = createPlanet(radius: 0.28, image: "planetSaturn")
        saturn.name = "saturn"
        saturn.position = SCNVector3(3.0, 0.0, 0.0)
        rotationEffect(rotation: 0.1, planet: saturn, duration: 1)
        rotationEffect(rotation: 0.1, planet: saturnOrbit, duration: 1)
        
        let saturnRing = SCNBox(width: 1.7, height: 0, length: 1.7, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named:"newRingSaturn")
        saturnRing.materials = [material]
        
        let saturnRingNode = SCNNode(geometry: saturnRing)
        saturnRingNode.position = SCNVector3(0.0, 0.0, 0.0)
        
        let uranusOrbit = createOrbitPath(orbitSize: 3.8)
        let uranus = createPlanet(radius: 0.23, image: "planetUranus")
        uranus.name = "uranus"
        uranus.position = SCNVector3(3.8, 0.0, 0.0)
        rotationEffect(rotation: 0.05, planet: uranus, duration: 1)
        rotationEffect(rotation: 0.05, planet: uranusOrbit, duration: 1)
        
        let neptuneOrbit = createOrbitPath(orbitSize: 4)
        let neptune = createPlanet(radius: 0.2, image: "planetNeptune")
        neptune.name = "neptune"
        neptune.position = SCNVector3(4, 0.0, 0.0)
        rotationEffect(rotation: 0.01, planet: neptune, duration: 1)
        rotationEffect(rotation: 0.01, planet: neptuneOrbit, duration: 1)
        
        let earthMoon = createPlanet(radius: 0.03, image: "earthMoon")
        earthMoon.name = "earthMoon"
        let moonRing = SCNTorus(ringRadius: 0.195, pipeRadius: 0)
        let moonRingNode = SCNNode(geometry: moonRing)
        
        earthMoon.position = SCNVector3(0.195 ,0.0 ,0.0)
        moonRingNode.position = SCNVector3(0.0 ,0.2 ,0.0)
        
        mercuryOrbit.addChildNode(mercury)
        venusOrbit.addChildNode(venus)
        earthOrbit.addChildNode(earth)
        marsOrbit.addChildNode(mars)
        jupiterOrbit.addChildNode(jupiter)
        saturnOrbit.addChildNode(saturn)
        saturn.addChildNode(saturnRingNode)
        uranusOrbit.addChildNode(uranus)
        neptuneOrbit.addChildNode(neptune)
        
        moonRingNode.addChildNode(earthMoon)
        earth.addChildNode(moonRingNode)
        
        spaceNode.addChildNode(sun)
        spaceNode.addChildNode(mercuryOrbit)
        spaceNode.addChildNode(venusOrbit)
        spaceNode.addChildNode(earthOrbit)
        spaceNode.addChildNode(marsOrbit)
        spaceNode.addChildNode(jupiterOrbit)
        spaceNode.addChildNode(saturnOrbit)
        spaceNode.addChildNode(uranusOrbit)
        spaceNode.addChildNode(neptuneOrbit)
        
        spaceNode.position = SCNVector3(0.0, 0.18, -1.5)
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.rootNode.addChildNode(spaceNode)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(checkNodeHit(_:)))
        tapGesture.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tapGesture)
        
    }
    
    //Going to Detail View when the Sun or Planet tapped
    @objc func checkNodeHit(_ gesture: UITapGestureRecognizer) {
        
        let currentTouchLocation = gesture.location(in: self.sceneView)
        
        guard let hitTestNode = self.sceneView.hitTest(currentTouchLocation, options: nil).first?.node else { return }
        
        switch hitTestNode.name {
            
        case "sun":
            self.clearScreen()
            
            let sun = createPlanet(radius: 0.5, image: "sun")
            sun.name = "focused"
            sun.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: sun, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "sunDescription")
            
            self.addComponent(node: sun)
            self.addComponent(node: description)
            
        case "mercury":
            self.clearScreen()
            
            let mercury = createPlanet(radius: 0.5, image: "planetMercury")
            mercury.name = "focused"
            mercury.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: mercury, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "mercuryDescription")
            
            self.addComponent(node: mercury)
            self.addComponent(node: description)
            
        case "venus":
            self.clearScreen()
            
            let venus = createPlanet(radius: 0.5, image: "planetVenus")
            venus.name = "focused"
            venus.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: venus, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "venusDescription")
            
            self.addComponent(node: venus)
            self.addComponent(node: description)
            
        case "earth":
            self.clearScreen()
            
            let earth = createPlanet(radius: 0.5, image: "planetEarth_day")
            earth.name = "focused"
            earth.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: earth, duration: 1)
            
            let earthMoon = createPlanet(radius: 0.1, image: "earthMoon")
            earthMoon.name = "earthMoon"
            let earthMoonOrbit = SCNTorus(ringRadius: 1.0, pipeRadius: 0)
            let earthMoonOrbitNode = SCNNode(geometry: earthMoonOrbit)
            
            earthMoon.position = SCNVector3(x:1.0 , y: 0, z: 0)
            earthMoonOrbitNode.position = SCNVector3(0.0 , -0.01, 0.57)
            earthMoonOrbitNode.addChildNode(earthMoon)
            earth.addChildNode(earthMoonOrbitNode)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "earthDescription")
            
            self.addComponent(node: earth)
            self.addComponent(node: description)
        
        case "earthMoon":
            self.clearScreen()
            
            let earthMoon = createPlanet(radius: 0.3, image: "earthMoon")
            earthMoon.name = "focused"
            earthMoon.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: earthMoon, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "earthMoonDescription")
            
            self.addComponent(node: earthMoon)
            self.addComponent(node: description)
            
        case "mars":
            self.clearScreen()
            
            let mars = createPlanet(radius: 0.5, image: "planetMars")
            mars.name = "focused"
            mars.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: mars, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "marsDescription")
            
            self.addComponent(node: mars)
            self.addComponent(node: description)
            
        case "jupiter":
            self.clearScreen()
            
            let jupiter = createPlanet(radius: 0.5, image: "planetJupiter")
            jupiter.name = "focused"
            jupiter.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: jupiter, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "jupiterDescription")
            
            self.addComponent(node: jupiter)
            self.addComponent(node: description)
            
        case "saturn":
            self.clearScreen()
            
            let saturn = createPlanet(radius: 0.2, image: "planetSaturn")
            saturn.name = "focused"
            saturn.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: saturn, duration: 1)
            
            let saturnRing = SCNBox(width: 1.5, height: 0, length: 1.5, chamferRadius: 0)
            let material = SCNMaterial()
            material.diffuse.contents = UIImage(named: "newRingSaturn")
            saturnRing.materials = [material]
            
            let saturnRingNode = SCNNode(geometry: saturnRing)
            saturnRingNode.position = SCNVector3(0, 0, 0)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "saturnDescription")
            
            saturn.addChildNode(saturnRingNode)
            
            self.addComponent(node: saturn)
            self.addComponent(node: description)
            
        case "uranus":
            self.clearScreen()
            
            let uranus = createPlanet(radius: 0.5, image: "planetUranus")
            uranus.name = "focused"
            uranus.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: uranus, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "uranusDescription")
            
            self.addComponent(node: uranus)
            self.addComponent(node: description)
            
        case "neptune":
            self.clearScreen()
            
            let neptune = createPlanet(radius: 0.5, image: "planetNeptune")
            neptune.name = "focused"
            neptune.position = SCNVector3(0, 0, 0)
            rotationEffect(rotation: 0.3, planet: neptune, duration: 1)
            
            let description = addDescription(height: 0.5, length: 0.5, image: "neptuneDescription")
            
            self.addComponent(node: neptune)
            self.addComponent(node: description)
            
        case "focused":
            self.viewDidLoad()
            
        default:
            print("Nothing tapped")
        }
        
    }
    
    //Create a planet, set its Size and choosing their textures
    func createPlanet(radius: Float, image: String) -> SCNNode {
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        
        material.diffuse.contents = UIImage(named: "\(image).jpeg")
        planet.materials = [material]
        
        let planetNode = SCNNode(geometry: planet)
        
        return planetNode
    }
    
    //Create an effect so the planet and sun can rotate on its own axis
    func rotationEffect(rotation: Float, planet: SCNNode, duration: Float) {
        let rotation = SCNAction.rotateBy(x:0, y:CGFloat(rotation), z:0, duration: TimeInterval(duration))
        planet.runAction(SCNAction.repeatForever(rotation))
    }
    
    //Clearing the screen when switching into a new node
    func clearScreen() {
        sceneView.scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
    }
    
    //Create a "Ring" for Planet to be able to Orbit
    func createOrbitPath(orbitSize: Float) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(orbitSize), pipeRadius: 0)
        let orbitPathNode = SCNNode(geometry: ring)
        
        return orbitPathNode
    }
    
    //Adding component while focusing on one planet
    func addComponent(node: SCNNode) {
        spaceNode.addChildNode(node)
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.scene.rootNode.addChildNode(spaceNode)
    }
    
    //Adding each planet description when enterint focused view
    func addDescription(height: CGFloat, length: CGFloat, image: String) -> SCNNode {
        let descriptionBox = SCNBox(width: height, height: length, length: 0, chamferRadius: 0)
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "\(image).png")
        descriptionBox.materials = [material]
        
        let descriptionNode = SCNNode(geometry: descriptionBox)
        descriptionNode.position = SCNVector3(0.7, 0.0, 0.8)
        
        return descriptionNode
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }
    
    // MARK: - ARSCNViewDelegate
    
    /*
     // Override to create and configure nodes for anchors added to the view's session.
     func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
     let node = SCNNode()
     
     return node
     }
     */
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
}
