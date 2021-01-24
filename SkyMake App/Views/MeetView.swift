//
//  MeetView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 19.01.2021.
//

import SwiftUI

struct MeetView: View {
    
    @Binding var appURL: String
    
    @Binding var username: String?
    @Binding var password: String?
    @Binding var LCID: String
    
    @Binding var meetServer: String
    @Binding var meetCode: String
    
    @Binding var currentPage: String
    
    @State var arStatus: String = ""
    
    @State var LCStatus = "Joining"
    @State var PIPLCStatus = "Joining"
    
    @State var dummyCP: String = ""
    
    @State var JitsiInstance: JitsiEmbed?
    
    var ar_timer: Timer {
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: true) {timerSelf in
                self.getARStatus()
                if self.currentPage != "Liveclass" {
                    timerSelf.invalidate()
                }
            }
        }
    
    func getARStatus(){
        
        let url_session = URLSession.shared
        
        var task_url = self.appURL + "/lc-embedded/"
        
        task_url = task_url + "?checkAR=yes"
        
        task_url = task_url + "&username="+self.username!
        
        task_url = task_url + "&password="+self.password!
        
        task_url = task_url + "&LCID="+self.LCID.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        
        let task = url_session.dataTask(with: URLRequest(url: URL(string: task_url)!)) { (data, URLResponse, error) in
            guard let data = data else { return }
            let apiARStatusResp: ARStatusResponse = try! JSONDecoder().decode(ARStatusResponse.self, from: data)
            
            if(apiARStatusResp.arStatus != "DISABLE_AR"){
                self.arStatus = apiARStatusResp.arStatus.lowercased().replacingOccurrences(of: " ", with: "_")
            } else {
                self.arStatus = apiARStatusResp.arStatus
            }
            
            
        }
        
        task.resume()
        
    } 
     
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

            if arStatus != "DISABLE_AR" && arStatus != "" {
                ZStack(alignment: Alignment(horizontal: .trailing, vertical: .top)){
                    InClassARView(modelNameToPlace: self.$arStatus)
                    let JI_PIP = JitsiEmbed(meetServer: self.$meetServer, meetCode: self.$meetCode, username: self.$username, currentPage: self.$dummyCP, LCStatus: self.$PIPLCStatus, redirectOnLeave: false, defaultLeaveSilenced: false, joinMuted: false)
                    JI_PIP
                        .frame(width: 300, height: 200, alignment: .topTrailing)
                        .cornerRadius(20)
                        .padding([.top,.trailing], 30)
                        .onDisappear(){
                            #if !targetEnvironment(macCatalyst)
                            JI_PIP.JMDel.doLeave()
                            #endif
                        }
                }
                
            }
            else {
                
                if JitsiInstance == nil{
                    
                    VStack{
                        
                        Spacer()
                        Text("Loding your meeting...")
                            .foregroundColor(.black)
                            .onAppear(){
                                JitsiInstance = JitsiEmbed(meetServer: self.$meetServer, meetCode: self.$meetCode, username: self.$username, currentPage: self.$currentPage, LCStatus: self.$LCStatus, redirectOnLeave: false, audioOnly: false)
                                
                            }
                        Spacer()
                        
                    }
                    
                }else{
                    if LCStatus != "Left"{
                        JitsiInstance
                        .onAppear(){
                            
                            _ = self.ar_timer
                            LCStatus = "Joined"
                            
                        }
                        .onDisappear(){
                            
                            #if !targetEnvironment(macCatalyst)
                            JitsiInstance?.silenceOnLeave()
                            JitsiInstance?.JMDel.doLeave()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                
                                if currentPage != "Home" {
                                    LCStatus = "BG"
                                }
                                
                            }
                            #endif
                            
                        }
                    } else {
                        
                        Spacer()
                        
                        Text("You have left the meeting")
                            .foregroundColor(.black)
                            .onAppear(){
                                
                                if (arStatus == "DISABLE_AR" || arStatus == "") && LCStatus == "Left" {
                                    
                                    currentPage = "Home"
                                    
                                }
                                
                            }
                        Spacer()
                        
                    }
                }
                    
                }
        }
    }
    
}
