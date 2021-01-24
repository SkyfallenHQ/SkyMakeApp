//
//  InClassARView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 24.01.2021.
//

import SwiftUI

struct InClassARView: View {
    
    @Binding var modelNameToPlace: String
    
    @State var modelToPlace: Model?
    @State var modelConfirmedforPlacement: Model?
    @State var isModelPicked: Bool = false
    
    var modelsStrArray: [String] = {
        
        let filemanager = FileManager.default
        
        guard let path = Bundle.main.resourcePath, let files = try? filemanager.contentsOfDirectory(atPath: path) else {
            return []
        }
        
        var availableModels: [String] = []
        
        for filename in files where filename.hasSuffix("usdz") {
            let modelName = filename.replacingOccurrences(of: ".usdz", with: "")
            
            availableModels.append(modelName)
        }
        
        return availableModels
        
    }()
 
    var body: some View {
        
        if modelsStrArray.contains(modelNameToPlace){
            
            ZStack(alignment: .bottom){
                ARViewContainer(modelConfirmedforPlacement: self.$modelConfirmedforPlacement)
                    .onAppear(){
                        modelToPlace = Model(modelName: modelNameToPlace)
                    }
                if modelToPlace != nil{
                    ModelPlacementConfirmView(isModelPicked: self.$isModelPicked, pickedModel: self.$modelToPlace, modelConfirmedforPlacement: self.$modelConfirmedforPlacement, showCancelOption: false)
                }
            }
        }else{
            
            VStack{
                
                Spacer()
                
                Text("This model is not supported by your device.")
                    .foregroundColor(.black)
                    .font(.title)
                Text("Please update your SkyMake App")
                    .foregroundColor(.gray)
                
                ScrollView(.vertical){
                    
                    Text("Models Supported:")
                        .font(.subheadline)
                    ForEach(0 ..< modelsStrArray.count){ index in
                        
                        Text(modelsStrArray[index])
                            .foregroundColor(.black)
                        
                    }
                }
                
                Spacer()
                
            }
            
        }
        
    }
}
