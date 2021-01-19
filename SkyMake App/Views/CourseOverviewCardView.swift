//
//  CourseOverviewCardView.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import SwiftUI

struct CourseOverviewCardView: View {
    var image: String
    var title: String
    var teacher: String
    var time: String
    
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading) {
                Image(uiImage: UIImage(data: try! Data(contentsOf: URL(string: image)!))!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 400,height: 250)
                
                Text(title)
                    .font(.system(size: 26, weight: .bold, design: .default))
                    .foregroundColor(.white)
                Text(teacher)
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
        .frame(width: 400, height: 500,alignment: .center)
        .padding(.all,20)
        .background(Color(red: 32/255, green: 36/255, blue: 38/255))
        .modifier(OverviewCardModifier())
        .padding(.all, 10)
    }

    struct OverviewCardModifier: ViewModifier {
        func body(content: Content) -> some View {
            content
                .cornerRadius(20)
                //.shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 0)
        }
        
    }
}
