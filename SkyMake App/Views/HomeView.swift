//
//  HomeView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var username: String?
    @Binding var password: String?
    
    @Binding var apiEndpoint: String
    @Binding var meetServer: String
    
    @Binding var currentPage: String
    @Binding var currentExam: String
    @Binding var currentDoc: String
    @Binding var currentMeeting: String
    
    @State private var courses: [APIResponse_Course] = []
    @State private var apiState: String = ".processing"
    
    @Binding var appURL: String
    
    @Binding var LCID: String
    
    var body: some View {
        
        VStack {
            Spacer()
            if apiState == ".idle" {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(0 ..< courses.count){
                            index in
                            FullCourseView(courseName: courses[index].name, courseDate: courses[index].time, courseImage: courses[index].image, courseTeacher: courses[index].teacher, courseContents: courses[index].contents, appURL: self.$appURL, meetServer: self.$meetServer, currentPage: self.$currentPage, currentExam: self.$currentExam, docURL: self.$currentDoc, currentMeeting: self.$currentMeeting, username: self.$username, password: self.$password, LCID: self.$LCID)
                            
                        }
                    }
                }
                
            }else{
                VStack{
                    Text("Loading your courses...")
                        .foregroundColor(.black)
                }
            }
            Spacer()
        }.onAppear(perform: {
            retrieveCourses(apiEndpoint: apiEndpoint, username: username!, password: password!)
        })
        
    }
    
    func retrieveCourses(apiEndpoint: String, username: String, password: String){
        
        let task = URLSession.shared.dataTask(with: URL(string: apiEndpoint+"/getAssignedCourses?username="+username+"&password="+password)!, completionHandler: { (data,response,error) in
            
            guard let data = data else { return }
            let apiResp: APIResponse = try! JSONDecoder().decode(APIResponse.self, from: data)
            
            let localCoursesArray: [APIResponse_Course] = (apiResp.result?.coursesArray)!
            
            for course in localCoursesArray{
                
                self.courses.append(course)
                print(course)
                
            }
            
            self.apiState = ".idle"
            
        })
        
        task.resume();
        
        return
    }
}
