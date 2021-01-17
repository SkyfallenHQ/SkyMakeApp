//
//  ContentView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 17.01.2021.
//

import SwiftUI
import RealityKit
import ARKit

struct ContentView : View {
    
    @State private var isModelPicked = false
    @State private var pickedModel: Model?
    @State private var modelConfirmedforPlacement: Model?
    
    private var models: [Model] = {
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availableModels: [Model] = []
        
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            
            let model = Model(modelName: modelName)
            
            availableModels.append(model)
        }
        
        return availableModels
    }()
    
    var body: some View {
        ZStack(alignment: .bottom){
            ARViewContainer(modelConfirmedforPlacement: self.$modelConfirmedforPlacement)
            if(self.isModelPicked){
                ModelPlacementConfirmView(isModelPicked: self.$isModelPicked, pickedModel: self.$pickedModel, modelConfirmedforPlacement: self.$modelConfirmedforPlacement)
            } else {
                ModelPickerView(isModelPicked: self.$isModelPicked, pickedModel: self.$pickedModel, models: self.models)
            }
        }.ignoresSafeArea(edges: .all)
    }
}

struct ModelPickerView: View {
    
    @Binding var isModelPicked: Bool
    @Binding var pickedModel: Model?

    var models: [Model]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30){
                ForEach(0 ..< self.models.count) {
                    index in
                    Button(action: {
                        print("SkyMake App | DEBUG: AR Model selected from:  \(self.models[index])")
                        
                        self.pickedModel = self.models[index]
                        
                        self.isModelPicked = true
                    }){
                        Image(uiImage: self.models[index].image)
                            .resizable()
                            .scaledToFill()
                            .padding(20)
                            .frame(width: 100, height: 100, alignment: .center)
                            .clipped()
                            .background(Color.white.opacity(0.8))
                            .cornerRadius(25)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
        }
        .padding(20)
        .background(Color.black.opacity(0.5))
        .padding(.bottom, 50)
    }
}

struct ModelPlacementConfirmView: View {
    
    @Binding var isModelPicked: Bool
    @Binding var pickedModel: Model?
    @Binding var modelConfirmedforPlacement: Model?
    
    var body: some View {
        
        HStack{
            Button(action: {
                print("SkyMake App | DEBUG: Item placement cancelled by user")
                resetModelPickedState()
            }){
                Image(systemName: "xmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
            Button(action: {
                print("SkyMake App | DEBUG: Item placement confirmed by user")
                
                self.modelConfirmedforPlacement = self.pickedModel
                
                resetModelPickedState()
            }){
                Image(systemName: "checkmark")
                    .frame(width: 60, height: 60)
                    .font(.title)
                    .background(Color.white.opacity(0.75))
                    .cornerRadius(30)
                    .padding(20)
            }
        }
        
    }
    func resetModelPickedState() {
        
        self.isModelPicked = false
        print("SkyMake App | DEBUG: Set ModelPicked State to initial value: (Bool) false")
        self.pickedModel = nil
        print("SkyMake App | DEBUG: Set pickedModel State to a nil value")
        
    }
}

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

#if DEBUG
struct ContentView_Previews : PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
