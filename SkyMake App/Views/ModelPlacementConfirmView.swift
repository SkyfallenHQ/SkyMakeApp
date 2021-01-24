//
//  ModelPlacementConfirmView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct ModelPlacementConfirmView: View {
    @Binding var isModelPicked: Bool
    @Binding var pickedModel: Model?
    @Binding var modelConfirmedforPlacement: Model?
    var showCancelOption: Bool = true
    
    var body: some View {
        
        HStack{
            if showCancelOption {
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
