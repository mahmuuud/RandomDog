//
//  ViewController.swift
//  RandomDog
//
//  Created by mahmoud mohamed on 2/18/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let endpointUrl = DogAPI.endPoint.randomPicsFromAllBreads.url
        DogAPI.requestRandImage(endPointUrl: endpointUrl,completionHandler: handleImageResponse(url:error:))
        let breedsUrl=URL(string: "https://dog.ceo/api/breeds/list/all")
        let task=URLSession.shared.dataTask(with: breedsUrl!) { (data, response, error) in
            guard let data=data else{
                return
            }
            let decoder=JSONDecoder()
            let allBreeds=try! decoder.decode(DogBreed.self, from: data)
            let breeds=allBreeds.message.keys
            print(breeds)
            let x="akisrgdta"
            if breeds.contains(x){
                print("+++++++++++++++++++++++++ contains")
            }
            else{
                print("=======================")
            }
        }
        task.resume()
    }
    
    func handleImageResponse(url:URL?,error:Error?){
        DogAPI.generateImageFromFile(url: url!, completionHandler: { (image, error) in
            guard let image=image else{
                return
            }
            self.displayImage(image: image)
        })
        
    }
    
    func displayImage(image:UIImage){
        DispatchQueue.main.async {
            self.imageView.image=image
        }
    }
}
