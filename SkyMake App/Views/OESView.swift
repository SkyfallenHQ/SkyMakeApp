//
//  OESView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 19.01.2021.
//

import SwiftUI

struct OESView: View {
    
    @Binding var appURL: String
    @Binding var username: String?
    @Binding var password: String?
    @Binding var currentExam: String
    
    var oes_ws = WebEmbed()
    
    var body: some View {
            oes_ws
            .onAppear(){
                var finalExamURL = appURL+"/oes/embedded/?username="+username!+"&password="+password!
                finalExamURL = finalExamURL + "&examid="+currentExam
                oes_ws.load(url: URL(string: finalExamURL)!)
        }
    }
}
