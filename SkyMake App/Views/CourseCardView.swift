//
//  CourseCardView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI
import UIKit

struct CourseCardView: View {
        var image: String
        var title: String
        var type: String
        var time: String
        
        var body: some View {
            HStack(alignment: .center) {
                Image(uiImage: UIImage(named: image)!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    //.padding(.all, 20)
                    .clipShape(Circle())
                    .shadow(radius: 10)
                    .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    
                
                VStack(alignment: .leading) {
                    Text(title)
                        .font(.system(size: 26, weight: .bold, design: .default))
                        .foregroundColor(.white)
                    Text(type)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.gray)
                    HStack {
                        Text(time)
                            .font(.system(size: 16, weight: .bold, design: .default))
                            .foregroundColor(.white)
                            .padding(.top, 8)
                    }
                }.padding(.trailing, 20)
                Spacer()
            }
            .frame(minWidth: 400,maxWidth: .infinity, alignment: .center)
            .padding(.all,20)
            .background(Color(red: 32/255, green: 36/255, blue: 38/255))
            .modifier(CardModifier())
            .padding(.all, 10)
        }
    
        struct CardModifier: ViewModifier {
            func body(content: Content) -> some View {
                content
                    .cornerRadius(20)
                    //.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
            }
            
        }
}
