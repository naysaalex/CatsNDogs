//
//  Animal.swift
//  CatsNDogsV1
//
//  Created by cashamirica on 3/27/23.
//

import Foundation

import CoreML
import Vision

struct Result: Identifiable{
    var imageLabel: String
    var confidence: Double
    var id = UUID()
}
//We will create a class animals and store important feature related information in it
class Animal{
    //url for the animal's image
    var imgurl: String
    
    //image Data
    var imageData:Data?
    
    //classifying the results
    var results: [Result]
    
    let modelFile = try! MobileNetV2(configuration: MLModelConfiguration())
    
    
    //creating an empty class of Animal
    init(){
        self.imgurl = ""
        self.imageData = nil
        self.results = [] //must initialize every variable created
        
    }//end of init
    
    init?(json:[String: Any]){
        //check if json has url
        guard let imageUrl = json["url"] as? String else {return nil}
        
        //set the animal property
        self.imgurl = imageUrl
        self.imageData = nil
        self.results = []
        
        //download image
        getImage()
        
    }
    
    func getImage(){
        //fill in later
        //1. create a url object
        let url = URL(string: imgurl) //revisit later
        
        //2. check if url is null
        guard url != nil else{print("couldn't find url")
            return
        }
        
        //3. get the url session
        let session = URLSession.shared
        
        //4. create the datatask
        let dataTask = session.dataTask(with: url!) { data, response, error in
            //check for error
            if error == nil && data != nil {
                self.imageData = data
                self.classifyAnimal()
            }//end of if
        }
        //5. start the data task
        dataTask.resume()
    }
    
    func classifyAnimal(){
        //get a reference to the model
        let model = try! VNCoreMLModel(for: modelFile.model)
        
        //create an image handler
        let handler = VNImageRequestHandler(data: imageData!)//exclamation mark means that you are forcing it --> can do this because you've already checked about nil
        
        //create a request to the model
        let request = VNCoreMLRequest(model: model){
            (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {
                print("Failed to classify animal")
                return
            }//end of else
            
            //update the result
            for classification in results{
                var identifier = classification.identifier
                identifier = identifier.prefix(1).capitalized + identifier.dropFirst()
                
                self.results.append(Result(imageLabel: identifier, confidence: Double(classification.confidence)))
            }//end of for
        }
        
        //execute the request
        do{
            try handler.perform([request])
        }catch{
            print("image format not supported")
        }
        
        
    }//end of classifyAnimal
}
