//
//  DogAPI.swift
//
//  Created by mahmoud mohamed on 2/18/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
class DogAPI{
    enum endPoint:String{
        case randomPicsFromAllBreads="https://dog.ceo/api/breeds/image/random"
        var url:URL{
            return URL(string: self.rawValue)!
        }
    }
    
    class func generateImageFromFile(url:URL,completionHandler:@escaping (UIImage?,Error?)->Void){
        let task=URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let image=UIImage(data: data)
            completionHandler(image,nil)
            
        }
        task.resume()
    }
    
    class func requestRandImage(endPointUrl:URL,completionHandler:@escaping (URL?,Error?)->Void){
        let task=URLSession.shared.dataTask(with: endPointUrl) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let decoder=JSONDecoder()
            let dogImage=try! decoder.decode(DogImage.self, from: data)
            let dogImageUrl=URL(string: dogImage.message)
            completionHandler(dogImageUrl,nil)
        }
        task.resume()
    }
}

