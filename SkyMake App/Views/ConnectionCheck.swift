//
//  ConnectionCheck.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 24.01.2021.
//

import SwiftUI

struct ConnectionCheck: View {
    
    @Binding var currentPage: String
    
    @State var currentAction: String = "Connecting to Skyfallen Servers..."
    
    var appURL: String = "https://app.deducated.com"
    var apiURL: String = "https://api.deducated.com"
    var meetURL: String = "https://meet.jit.si"
    
    var body: some View {
        
        HStack{
            
            
            Spacer()
            
            VStack{
                
                
                Spacer()
                
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color.black))
                Text(currentAction)
                    .foregroundColor(.black)
                    .padding(.top, 10)
                    .onAppear(){
                        
                        //let start = DispatchTime.now()
                        
                        let test1_url = URL(string: "https://www.theskyfallen.com")
                        
                        let test1_request = URLRequest(url: test1_url!)
                        
                        let test1_task = URLSession.shared.dataTask(with: test1_request) { (data, URLResponse, error) in
                            
                            print(error ?? "test1:success")
                            
                            if error == nil {
                                
                                currentPage = "Login"
                                
                                /*
                                currentAction = "Trying to query the Application Server..."
                                
                                let test2_url = URL(string: appURL)
                                
                                let test2_request = URLRequest(url: test2_url!)
                                
                                let test2_task = URLSession.shared.dataTask(with: test2_request) { (data, URLResponse, error) in
                                    
                                    print(error ?? "test2:success")
                                    
                                    if error == nil {
                                        
                                        currentAction = "Connecting to the API..."
                                        
                                        let test3_url = URL(string: apiURL)
                                        
                                        let test3_request = URLRequest(url: test3_url!)
                                        
                                        let test3_task = URLSession.shared.dataTask(with: test3_request) { (data, URLResponse, error) in
                                            
                                            print(error ?? "test3:success")
                                            
                                            if error == nil {
                                                
                                                currentAction = "API Connected"
                                                
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                        
                                                    currentAction = "Connecting to the meeting server..."
                                                    
                                                    let test4_url = URL(string: meetURL)
                                                    
                                                    let test4_request = URLRequest(url: test4_url!)
                                                    
                                                    let test4_task = URLSession.shared.dataTask(with: test4_request) { (data, URLResponse, error) in
                                                        
                                                        print(error ?? "test4:success")
                                                        
                                                        if error == nil {
                                                            
                                                            let end = DispatchTime.now()
                                                            
                                                            let nanoTime = end.uptimeNanoseconds - start.uptimeNanoseconds
                                                            let timeInterval = Double(nanoTime) / 1_000_000_000
                                                            let readableTook = String(format: "%.1f", timeInterval)
                                                            
                                                            currentAction = "Tests completed in \(readableTook) seconds."
                                                            
                                                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                                                
                                                                if timeInterval > 8.0 {
                                                                    
                                                                    currentAction = "Your connection is very slow, please switch to a better network."
                                                                    
                                                                } else {
                                                                    
                                                                    if timeInterval > 5.0 {
                                                                        
                                                                        currentAction = "Your connection is a bit slow, you may experience delays."
                                                                        
                                                                    } else {
                                                                        
                                                                            currentAction = "You have an optimal connection."
                                                                        
                                                                    }
                                                                    
                                                                }

                                                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                                                
                                                                currentAction = "Loading..."
                                                                
                                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.75) {
                                                                            
                                                                            currentPage = "Login"
                                                                        
                                                                    }
                                                                }
                                                            }
                                                            
                                                            
                                                        }
                                                        
                                                    }
                                                    
                                                    test4_task.resume()
                                                    
                                                }
                                                
                                                
                                            }
                                            
                                        }
                                        
                                        test3_task.resume()
                                        
                                    }
                                    
                                }
                                
                                test2_task.resume()
                              */
                            } else {
                                
                                currentAction = error!.localizedDescription
                                
                            }
                            
                        }
                        
                        
                        test1_task.resume()
                        
                    }
                
                Spacer()
                
            }
            
            Spacer()
            
            
        }
        
    }
}
