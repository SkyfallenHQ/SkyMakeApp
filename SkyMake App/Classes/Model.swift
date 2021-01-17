//
//  Model.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 17.01.2021.
//

import UIKit
import RealityKit
import Combine

class Model {
    
    var modelName: String
    var image: UIImage
    var modelEntity: ModelEntity?
    
    private var cancellable: AnyCancellable? = nil
    
    init(modelName: String){
    
        self.modelName = modelName
        
        self.image = UIImage(named: modelName)!
        
        let filename = modelName + ".usdz"
        
        self.cancellable = ModelEntity.loadModelAsync(named: filename)
            .sink(receiveCompletion: { loadCompletion in
                
                print("SkyMake App | DEBUG: Can not load AR Model. ModelName: \(self.modelName)")
                
            }, receiveValue: { modelEntity in
                
                self.modelEntity = modelEntity
                
                print("SkyMake App | DEBUG: AR Model Entity successfully loaded, modelName: \(self.modelName)")
                
            })
        
    }
}
