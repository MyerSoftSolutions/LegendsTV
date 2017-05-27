//
//  JSONHandler.swift
//  Legends TV
//
//  Created by Joel Myers on 5/27/17.
//  Copyright © 2017 Legends Media. All rights reserved.
//

import Foundation

final class JSONHandler {
    static let defaultHandler = JSONHandler()
    private static let filePath = "VideoFeedApril2017-2"

    private var jsonFile : [String : Any]?
    private init() {
        self.readJson()
    }
    
    private func readJson() {
        do {
            if let file = Bundle.main.url(forResource: JSONHandler.filePath, withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let object = json as? [String: Any] {
                    // json is a dictionary
                    print(object)
                    jsonFile = object
                } else if let object = json as? [Any] {
                    // json is an array
                    print(object)
                } else {
                    print("JSON is invalid")
                }
            } else {
                print("no file")
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func parseMovieArray () -> [[String : Any]] {
    
        let arr : [[String : Any]] = jsonFile!["movies"] as! [[String : Any]]
        
        return arr
    }
    

}
