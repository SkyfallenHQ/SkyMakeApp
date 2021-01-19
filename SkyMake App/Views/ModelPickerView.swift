//
//  ModelPickerView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

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
