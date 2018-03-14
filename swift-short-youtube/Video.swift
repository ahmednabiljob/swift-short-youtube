//
//  File.swift
//  swift-short-youtube
//
//  Created by Ahmed on 3/13/18.
//  Copyright © 2018 Ahmed. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

struct Video{
    var videoUrlString: String
    var imageUrlString:String
    var videoTitle:String
    
    init(videoUrlString: String, imageUrlString: String, title: String ) {
        self.videoUrlString = videoUrlString
        self.imageUrlString = imageUrlString
        self.videoTitle = title
    }
}

class VideoHelper{
    let keyword:String
    let videoType:String
    var videoArray = [Video]()
    
    init(keyword:String){
        self.keyword = keyword
        self.videoType = "video"
    }
    
    func fetchVideos(_ completionHandler: @escaping ([Video]) -> Void){
        
        let requestedURL = "https://www.googleapis.com/youtube/v3/search?part=snippet&q=\(self.keyword)&type=\(self.videoType)&key=\("AIzaSyAxmwhMwfSYoOtTXNsuSRHJ0ec9bb-d8PE")"
        let _ = Alamofire.request(URL(string: requestedURL)!).responseJSON { response in
            //print("Request: \(String(describing: response.request))")   // original url request
            //print("Response: \(String(describing: response.response))") // http url response
            //print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                //print("JSON: \(json)") // serialized json response
                let jsonObj = JSON(json)
                //print(jsonObj["items"])
                //print("Parsing JSON ........")
                let items=jsonObj["items"].arrayValue
                for item in items{
                    let videoID = item["id"]["videoId"].stringValue
                    let videoTitle = item["snippet"]["title"].stringValue
                    let thumbnailUrl = item["snippet"]["thumbnails"]["default"]["url"].stringValue
                    //print("\(videoID) has title=\(videoTitle) with url=\(thumbnailUrl)")
                    self.videoArray.append(Video(videoUrlString: videoID, imageUrlString: thumbnailUrl, title: videoTitle))
                }
                
            }
            completionHandler(self.videoArray)
            /*
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                //print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            */
        }
        
    }
}
