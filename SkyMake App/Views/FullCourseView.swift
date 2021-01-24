//
//  FullCourseView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct FullCourseView: View {
        
    var courseName: String
    var courseDate: String
    var courseImage: String
    var courseTeacher: String
    var courseContents: [APIResponse_CourseContent]
    @Binding var appURL: String
    @Binding var meetServer: String

    @Binding var currentPage: String
    @Binding var currentExam: String
    @Binding var docURL: String
    @Binding var currentMeeting: String
    
    @Binding var username: String?
    @Binding var password: String?

    @Binding var LCID: String

    var body: some View {
        
                
                HStack{
                    
                    CourseOverviewCardView(image: courseImage, title: courseName, teacher: courseTeacher, time: courseDate)
                
                    if courseContents.count != 0{
                        VStack{
                            
                        }
                        .padding(.top, 550)
                        .padding(.leading,525)
                        .overlay(
                            ScrollView(.vertical, showsIndicators: false) {
                            ForEach(0 ..< courseContents.count){ index in
                                switch courseContents[index].type {
                                
                                case "Online Exam":
                                    Button(action: {
                                        currentPage = "OES"
                                        currentExam = courseContents[index].id
                                    }){
                                    CourseCardView(image: "Class", title: courseContents[index].id , type: courseContents[index].type, time: courseName)
                                    }
                                    
                                case "Live Class":
                                    Button(action: {
                                        let url_session = URLSession.shared
                                        
                                        var url = appURL + "/lc-embedded/"
                                        
                                        url = url + "?username="+username!+"&password="+password!
                                        
                                        url = url + "&LCID="+courseContents[index].id.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
                                        
                                        let url_t = URL(string: url)
                                        
                                        print(url)
                                        
                                        let lc_task = url_session.dataTask(with: URLRequest(url: url_t!)) { (data, URLResponse, error) in
                                            guard let data = data else { return }
                                            
                                            print(String(decoding: data, as: UTF8.self))
                                            
                                            let apiResp: APP_LCResponse = try! JSONDecoder().decode(APP_LCResponse.self, from: data)
                                            #if targetEnvironment(macCatalyst)
                                            UIApplication.shared.open(URL(string: apiResp.meetServer! + "/" + apiResp.meetCode!)!)
                                            #else
                                            if apiResp.error != "notstarted" {
                                                currentMeeting = apiResp.meetCode!
                                                meetServer = apiResp.meetServer!
                                                currentPage = "Liveclass"
                                                LCID = courseContents[index].id
                                            } else {
                                                currentMeeting = "INTERNAL:SMAPP:NotStartedByAuthorised"
                                            }
                                            #endif
                                            
                                        }
                                        
                                        lc_task.resume()
                                    }){
                                    CourseCardView(image: "Exam", title: courseContents[index].id , type: courseContents[index].type, time: courseName)
                                    }
                                
                                case "Document":
                                    Button(action: {
                                        currentPage = "Document"
                                        docURL = courseContents[index].url
                                    }){
                                    CourseCardView(image: "Doc", title: courseContents[index].id , type: courseContents[index].type, time: courseName)
                                    }
                                    
                                default:
                                    CourseCardView(image: "Class", title: courseContents[index].id , type: courseContents[index].type, time: courseName)
                                
                                }
                                
                            }

                        },alignment: .center)
                    }
                }
                
        
    }

    struct APP_LCResponse: Decodable {
        
        var meetCode: String?
        var meetServer: String?
        var error: String?
        
    }

}
