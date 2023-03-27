//
//  Animal.swift
//  CatsNDogsV1
//
//  Created by cashamirica on 3/27/23.
//

import Foundation

//We will create a class animals and store important feature related information in it
class Animal{
    //url for the animal's image
    var imgurl: String
    
    //image Data
    var imageData:Data?
    
    //creating an empty class of Animal
    init(){
        self.imgurl = ""
        self.imageData = nil
        
    }//end of init
    
    init?(json:[String: Any]){
        //check if json has url
        guard let imageUrl = json["url"] as? String else {return nil}
        
        //set the animal property
        self.imgurl = imageUrl
        self.imageData = nil
        
        //download image
        getImage()
        
    }
    
    func getImage(){
        //fill in later
    }
}
