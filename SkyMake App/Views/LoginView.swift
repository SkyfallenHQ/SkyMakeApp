//
//  LoginView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct LoginView: View {
    
    @Binding var username: String?
    @Binding var password: String?
    @Binding var currentPage: String
    @Binding var userRole: String?
    
    
    @Binding var apiEndpoint: String
    
    @State private var formUsername: String = ""
    @State private var formPassword: String = ""
    @State private var incorrectPassword: Bool = false
    
    
    var body: some View {
        VStack{
            
            if incorrectPassword{
                Spacer()
                Text("Incorrect Username or Password!")
                    .foregroundColor(.red)
                    .padding(.bottom,10)
                Divider()
            }
            
            Spacer()
            
            HStack {
              Image(systemName: "person").foregroundColor(.gray)
              ZStack(alignment: .leading) {
              if formUsername == "" { Text("Username").foregroundColor(.black) }
                        TextField("", text: $formUsername)
                            .foregroundColor(.black)
              }
              if formUsername == "" {
                      Image(systemName:"exclamationmark.triangle.fill").foregroundColor(Color.red)
              }
            }
            Divider()
            
            HStack {
              Image(systemName: "lock").foregroundColor(.gray)
              ZStack(alignment: .leading) {
              if formPassword == "" { Text("Password").foregroundColor(.black) }
                        SecureField("", text: $formPassword)
                            .foregroundColor(.black)
              }
              if formPassword == "" {
                      Image(systemName:"exclamationmark.triangle.fill").foregroundColor(Color.red)
              }
            }
            Divider()
                
            Button(action: {
                
                let url_session = URLSession.shared
                
                let login_request_task = url_session.dataTask(with: URLRequest(url: URL(string: apiEndpoint + "/getUserRole?username="+formUsername+"&password="+formPassword)!)) { (data, URLResponse, error) in
                    guard let data = data else { return }
                    let apiAuthTestResp: APIResponse = try! JSONDecoder().decode(APIResponse.self, from: data)
                    switch apiAuthTestResp.status?.code! {
                    
                    case "200":
                        currentPage = "Home"
                        username = formUsername
                        password = formPassword
                        userRole = apiAuthTestResp.result?.string
                        
                    case "403":
                        incorrectPassword = true
                        
                    default:
                        incorrectPassword = true
                    }
                }
                
                login_request_task.resume()
                
            }){
                Text("Login")
                    .foregroundColor(.white)
                    .padding([.leading,.trailing], 20)
                    .padding([.bottom,.top], 10)
                    .background(Color.black)
                    .cornerRadius(12)
            }
            
            Spacer()
        }
        .frame(width: 300)
    }
}
