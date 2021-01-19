//
//  SelfServedARView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct SelfServedARView: View {
    
    @State private var isModelPicked = false
    @State private var pickedModel: Model?
    @State private var modelConfirmedforPlacement: Model?
    
    private var models: [Model] = {
        
        #if targetEnvironment(macCatalyst)
            print("SkyMake App | DEBUG: Cancelled loading of models, Catalyst detected.")
            return []
        #else
        
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
        
        #endif
    }()
    
    #if targetEnvironment(macCatalyst)
    var body: some View {
        Spacer()
        HStack{
            Text("To use SkyMake Augmented Reality, you need an iPad running iPadOS 14 or above.")
                .foregroundColor(.black)
        }
        Spacer()
    
    }
    #else
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
    
    #endif
}
