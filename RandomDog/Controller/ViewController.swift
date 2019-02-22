//
//  ViewController.swift
//  RandomDog
//
//  Created by mahmoud mohamed on 2/18/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    var breeds:[String]!
    var selectedBreed:String!
    override func viewDidLoad() {
        super.viewDidLoad()
        DogAPI.listAllBreeds(completionHandler: handleBreedsResponse(breeds:error:))
   
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
    
    func handleBreedsResponse(breeds:[String]?,error:Error?){
        guard let breeds=breeds else{
            return
        }
        self.breeds=breeds
        self.setDelegates()
    }
    
    func setDelegates(){
        DispatchQueue.main.async {
            self.pickerView.delegate=self
            self.pickerView.dataSource=self
        }
    }
}
