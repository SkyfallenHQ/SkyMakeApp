//
//  SkyMakeARView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 17.01.2021.
//

import ARKit
import FocusEntity
import RealityKit
import SwiftUI
import UIKit
import Combine


class SkyMakeARView: ARView{
    var focusEntity: FocusEntity?
    required init(frame frameRect: CGRect) {
      super.init(frame: frameRect)
      self.setupConfig()
      self.focusEntity = FocusEntity(on: self, focus: .classic)
      //self.focusEntity = FocusEntity(on: self, style: .colored(onColor: .red, offColor: .blue, nonTrackingColor: .orange))
    }

    func setupConfig() {
      let config = ARWorldTrackingConfiguration()
      config.planeDetection = [.horizontal, .vertical]
      config.environmentTexturing = .automatic
      session.run(config, options: [])
    }
    
    @objc required dynamic init?(coder decoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
  }

extension SkyMakeARView: FocusEntityDelegate {
    func toTrackingState() {
      print("tracking")
    }
    func toInitializingState() {
      print("initializing")
    }
  }
