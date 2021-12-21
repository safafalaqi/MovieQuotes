//
//  DataLoader.swift
//  Movie Quotes
//
//  Created by Safa Falaqi on 21/12/2021.
//

import Foundation



public class DataLoader{
    
    @ Published var movieData = [Movie]()
   
    
    init(){
        load()
    }
    func load(){
        
        if let sourceURL = Bundle.main.url(forResource: "data", withExtension: "json")  {
            
            do{
                let data = try Data(contentsOf: sourceURL)
                let decoder =  JSONDecoder()
                let dataFromJson = try decoder.decode([Movie].self, from: data)
                self.movieData = dataFromJson
                
            }catch{
                print(error)
            }
        }
    }
    
    
}
