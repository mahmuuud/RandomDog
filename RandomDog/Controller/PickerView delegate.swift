//
//  PickerView delegate.swift
//  RandomDog
//
//  Created by mahmoud mohamed on 2/22/19.
//  Copyright © 2019 mahmoud mohamed. All rights reserved.
//

import Foundation
import UIKit
extension ViewController:UIPickerViewDelegate,UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.breeds.count
    }
    
    func pickerView(_: UIPickerView, titleForRow row: Int, forComponent: Int)->String?{
        return self.breeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow: Int, inComponent: Int){
        let endpointUrl = DogAPI.endPoint.randomPicsFromAllBreads.url
        self.selectedBreed=self.breeds[didSelectRow]
        DogAPI.requestRandImage(breed:self.selectedBreed,completionHandler: handleImageResponse(url:error:))
        print(self.selectedBreed!)
    }
}
