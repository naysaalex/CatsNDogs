//
//  AnimalModel.swift
//  CatsNDogsV1
//
//  Created by cashamirica on 3/27/23.
//

import Foundation

class AnimalModel{
     var animal = Animal()
    
    func getAnimal(){//meant to get the data
        let stringUrl = Bool.random() ? catUrl: dogUrl
        
        //1. create the url object
        let url = URL(string: stringUrl)
        
        //2. check if url is empty
        guard url != nil else{
            print("couldn't find image")
            return
        }
        
        //3. get url
        let session = URLSession.shared
        
        //4. create data task
        //forcing it to take the url with the "url!" at the beginning of the code
        //normally can't force it but can do it here since we manually check whether it is nil or not
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil && data != nil{
                do{
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as?[[String: Any]]/*two brackets around this since it is a 2D array*/{
                        let item = json.isEmpty ? [:] : json[0]
                        
                        
                        if let animal = Animal(json: item){
                            DispatchQueue.main.async{
                                while animal.imageData == nil {} //put this to give system time to download data
                                //works like a sleep - checking if it is nil, keep going and as soon as you get something you get out of it
                                self.animal = animal
                            } //end of dispatch
                        }//end of if let animal
                    }//end of if let json
                } // end of do
                catch{
                    print ("json parsing failed")
                }
                
            }
        }
        
    }
}
