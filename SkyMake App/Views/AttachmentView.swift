//
//  AttachmentView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 19.01.2021.
//

import SwiftUI

struct AttachmentView: View {
    @Binding var appURL: String
    @Binding var currentDoc: String
    
    var atch_ws = WebEmbed()
    
    var body: some View {
            atch_ws
            .onAppear(){
                var docURL = currentDoc.replacingOccurrences(of: "UserUploads/", with: "")
                docURL = docURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                
                let finalURL = appURL+"/UserUploads/"+docURL
                print(finalURL)
                atch_ws.load(url: URL(string: finalURL)!)
        }
    }
    
}
