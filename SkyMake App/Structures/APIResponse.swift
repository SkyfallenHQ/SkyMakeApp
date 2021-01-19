//
//  APIResponse.swift
//  SkyMake App
//
//  Created by Yigit Kerem Oktay on 18.01.2021.
//

import Foundation

struct APIResponse: Decodable{
    
    var api: APIResponse_APIDetails?
    var status: APIResponse_APIRequestStatus?
    var error: APIResponse_APIRequestError?
    var result: APIResponse_APIResult?
    
}
struct APIResponse_APIDetails: Decodable{
    
    var vendor: String?
    var version: String?
    var name: String?
    
}

struct APIResponse_APIRequestStatus: Decodable{
    
    var code: String?
    var message: String?
    
}

struct APIResponse_APIRequestError: Decodable{
    
    var description: String?
    
}

struct APIResponse_APIResult: Decodable{
    
    var string: String?
    var stringArray: [String]?
    var coursesArray: [APIResponse_Course]?
    
}

struct APIResponse_Course: Decodable{
    
    var name: String
    var time: String
    var teacher: String
    var image: String
    var contents: [APIResponse_CourseContent]
    
}

struct APIResponse_CourseContent: Decodable {
    
    var id: String
    var url: String
    var type: String
    
}
