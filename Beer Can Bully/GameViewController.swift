/**
 * Copyright (c) 2016 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit
import GameplayKit
import SceneKit
import SpriteKit

class GameViewController: UIViewController {
  
  let helper = GameHelper()
  // Scene properties
  var menuScene = SCNScene(named: "resources.scnassets/Menu.scn")!
  var levelScene = SCNScene(named: "resources.scnassets/Menu.scn")!
  
  // Accessor for the SCNView
  var scnView: SCNView {
    let scnView = view as! SCNView
    
    scnView.backgroundColor = UIColor.black
    
    return scnView
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    presentMenu()
  }
  
  // MARK: - Touches
  override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesBegan(touches, with: event)
    if helper.state == .tapToPlay {
      presentLevel()
    }
  }
  
  override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    super.touchesEnded(touches, with: event)
    
  }
  
  // MARK: - ViewController Overrides
  override var prefersStatusBarHidden : Bool {
    return true
  }
  
  override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
    return UIDevice.current.userInterfaceIdiom == .phone ? .portrait : .all
  }
  // MARK: - Helpers
  func presentMenu() {
    let hudNode = menuScene.rootNode.childNode(withName: "hud", recursively: true)!
    hudNode.geometry?.materials = [helper.menuHUDMaterial]
    hudNode.rotation = SCNVector4(x: 1, y: 0, z: 0, w: Float(M_PI))
    
    helper.state = .tapToPlay
    
    let transition = SKTransition.crossFade(withDuration: 1.0)
    scnView.present(
      menuScene,
      with: transition,
      incomingPointOfView: nil,
      completionHandler: nil
    )
  }
  func presentLevel() {
    helper.state = .playing
    let transition = SKTransition.crossFade(withDuration: 1.0)
    scnView.present(levelScene, with: transition, incomingPointOfView: nil, completionHandler: nil)
  }

}
