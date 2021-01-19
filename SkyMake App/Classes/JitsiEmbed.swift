//
//  JitsiMeeting.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 19.01.2021.
//

#if !targetEnvironment(macCatalyst)
    import Foundation
    import UIKit
    import SwiftUI
    import JitsiMeet

    struct JitsiEmbed: UIViewRepresentable {

        @Binding var meetServer: String
        @Binding var meetCode: String
        
        public func makeUIView(context: Context) -> JitsiMeetView {
            

            let defaultOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.serverURL = URL(string: meetServer)
                builder.welcomePageEnabled = false
            }
            
            JitsiMeet.sharedInstance().defaultConferenceOptions = defaultOptions
            
            let jitsiMeetView = JitsiMeetView()
            let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.room = meetCode
            }
                
            
            jitsiMeetView.join(options)
            
            return jitsiMeetView
            
        }

        public func updateUIView(_ uiView: JitsiMeetView , context: Context) {
            func conferenceTerminated(_ data: [AnyHashable : Any]!) {
                DispatchQueue.main.async {
                    print("Call Close")
                }
            }

        }
    }
#else
import SwiftUI

struct JitsiEmbed: View{
    
    @Binding var meetServer: String
    @Binding var meetCode: String
    
    var body: some View {
        
        VStack{
            
            Spacer()
            Text("Embedded Meetings are not supported on this platform.")
                .foregroundColor(.black)
                .font(.title)
            Spacer()
            
        }
        
    }
    
}
#endif
