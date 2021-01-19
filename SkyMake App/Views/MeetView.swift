//
//  MeetView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 19.01.2021.
//

import SwiftUI

struct MeetView: View {
    
    @Binding var meetServer: String
    @Binding var meetCode: String
    
    var body: some View {
        if meetCode == "INTERNAL:SMAPP:NotStartedByAuthorised"{
            VStack{
                
                Spacer()
                Text("This meeting has not started.")
                    .foregroundColor(.black)
                    .font(.title)
                Spacer()
                
            }
        } else {
            JitsiEmbed(meetServer: self.$meetServer, meetCode: self.$meetCode)
        }
    }
}
