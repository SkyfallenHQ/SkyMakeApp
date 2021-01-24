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
        @Binding var username: String?
        @Binding var currentPage: String
        @Binding var LCStatus: String
        @State public var jitsiDoingSilentLeave: Bool = false
        
        public var redirectOnLeave: Bool = true
        
        public var defaultLeaveSilenced: Bool = false
        
        @State var JMView: JitsiMeetView?
        
        public var joinMuted: Bool = false
        public var audioOnly: Bool = true
        
        let JMDel = JMDelegate(jitsiView: nil, viewSelf: nil)
        
        public func makeUIView(context: Context) -> JitsiMeetView {

            jitsiDoingSilentLeave = defaultLeaveSilenced
            
            let defaultOptions = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.serverURL = URL(string: meetServer)
                builder.welcomePageEnabled = false
            }
            
            JitsiMeet.sharedInstance().defaultConferenceOptions = defaultOptions
            
            let jitsiMeetView = JitsiMeetView()
            DispatchQueue.main.async {
                JMView = jitsiMeetView
            }
            JMDel.viewSelf = self
            
            let options = JitsiMeetConferenceOptions.fromBuilder { (builder) in
                builder.room = meetCode
                builder.subject = "Skyfallen LiveConnect (AR)"
                builder.userInfo = JitsiMeetUserInfo(displayName: username!, andEmail: username!+"@ne.sm.thesf.me", andAvatar: URL(string: "https://github.com/yigitkeremoktay/ProjectScreenshots/raw/master/SkyfallenAPP.png"))
                builder.audioMuted = self.joinMuted
                builder.videoMuted = audioOnly
                
            }
            LCStatus = "Joined"
            jitsiMeetView.join(options)
            
            JMDel.JitsiView = jitsiMeetView
            
            jitsiMeetView.delegate = JMDel
            
            return jitsiMeetView
            
        }

        public func updateUIView(_ uiView: JitsiMeetView , context: Context) {

        }
        
        public func goToPage(newPage: String) {
            
            currentPage = newPage
            
        }
        
        public func silenceOnLeave() {
            
            jitsiDoingSilentLeave = true
            
        }
    
        public func changeLCStatus(newStatus: String){
            
            LCStatus = newStatus
            
        }
    }

class JMDelegate: NSObject, JitsiMeetViewDelegate {
    
    init(jitsiView: JitsiMeetView?, viewSelf: JitsiEmbed?) {
        
        self.JitsiView = jitsiView
        
        self.viewSelf = viewSelf
        
    }
    
    var JitsiView: JitsiMeetView?
    var viewSelf: JitsiEmbed?
    
    func conferenceTerminated(_ data: [AnyHashable : Any]!) {
        print("Leaving Conference")
        
        self.viewSelf?.changeLCStatus(newStatus: "Left")
        
        if viewSelf!.redirectOnLeave {
            
            if viewSelf?.jitsiDoingSilentLeave == false {
                self.viewSelf?.goToPage(newPage: "Home")
            } else {
                
                print("Aborted redirect to home, notified about silent leave")
                
            }
            
        }
    }
    
    func doLeave(){
        
        JitsiView?.leave()
        
    }
}

#else
import SwiftUI

struct JitsiEmbed: View{
    
    @Binding var meetServer: String
    @Binding var meetCode: String
    @Binding var username: String?
    @Binding var currentPage: String
    @Binding var LCStatus: String
    @State public var jitsiDoingSilentLeave: Bool = false
    
    public var redirectOnLeave: Bool = true
    
    public var defaultLeaveSilenced: Bool = false
    
    public var joinMuted: Bool = false
    public var audioOnly: Bool = true
    
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
