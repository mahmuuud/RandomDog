//
//  DogAPI.swift
//
//  Created by mahmoud mohamed on 2/18/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
class DogAPI{
    enum endPoint{
        case randomPicsFromAllBreads
        case randomPicForBreed(String)
        
        var url:URL{
            return URL(string: stringValue)!
        }
        
        var stringValue:String{
            switch self {
            case .randomPicsFromAllBreads:
                return "https://dog.ceo/api/breeds/image/random"
            case.randomPicForBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
                        }
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
    
    class func requestRandImage(breed:String,completionHandler:@escaping (URL?,Error?)->Void){
        let endPointUrl=DogAPI.endPoint.randomPicForBreed(breed).url
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
    
    class func listAllBreeds(completionHandler:@escaping ([String]?,Error?)->Void){
        let breedsUrl=URL(string: "https://dog.ceo/api/breeds/list/all")
        let task=URLSession.shared.dataTask(with: breedsUrl!) { (data, response, error) in
            guard let data=data else{
                completionHandler(nil,error)
                return
            }
            let decoder=JSONDecoder()
            let allBreeds=try! decoder.decode(DogBreed.self, from: data)
            let breeds=allBreeds.message.keys.map({$0})
            completionHandler(breeds,nil)
        }
        task.resume()
    }
}

