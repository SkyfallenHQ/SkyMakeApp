//
//  ARViewContainer.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI
import ARKit
import RealityKit
import Combine
import UIKit

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelConfirmedforPlacement: Model?
    
    func makeUIView(context: Context) -> ARView {
        
        let arView = SkyMakeARView(frame: .zero)//ARView(frame: .zero)
        
        return arView
        
    }
    
    func updateUIView(_ uiView: ARView, context: Context) {
        
        if let model = self.modelConfirmedforPlacement {
            
            if let modelEntity = model.modelEntity {
               
                print("SkyMake App | DEBUG: Adding model to the AR Scene, Model Name: \(model.modelName)")
                
                let anchorEntity = AnchorEntity(plane: .any)
                
                anchorEntity.addChild(modelEntity.clone(recursive: true))
                
                uiView.scene.addAnchor(anchorEntity)
                
            } else {
                
                print("SkyMake App | DEBUG: Failed to load model entity for model: \(model.modelName)")
                
            }
            
            DispatchQueue.main.async {
                self.modelConfirmedforPlacement = nil
            }
        }
        
    }
}
