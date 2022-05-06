//
//  StoryboardHandler.swift
//  STDevExample
//
//  Created by enigma 2 on 2/15/1401 AP.
//

import Foundation
import Alamofire
import SwiftyJSON


class InternetServices {
    static var shared = InternetServices()
    
    
    let headers: HTTPHeaders = [
            "Content-type": "json"
        ]
    
    func getAllProducts(completion : @escaping completionProductArray){
        
        var products = [Product]()
        
        AF.request(GET_ALL_PRODUCT).validate().responseJSON { res in
            
            switch res.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                do{
                    products = try JSONDecoder().decode([Product].self, from: json.description.data(using: .utf8)!)
                    print(products.count)
                    
                }catch{
                    print(error.localizedDescription)
                    print(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completion(products)
        }
        
        
    }
    
    
    func getAllCategories(completion : @escaping completionCategories){
        
        var categories = [String]()
        
        AF.request(GET_ALL_CATEGORIES).validate().responseJSON { res in
            
            switch res.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                do{
                    categories = try JSONDecoder().decode([String].self, from: json.description.data(using: .utf8)!)
                    print(categories.count)
                    
                }catch{
                    print(error.localizedDescription)
                    print(error)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
            
            completion(categories)
        }
        
        
    }
    
    func loginUser( email : String , password: String , completion : @escaping completionBool){
        // this api just accept this so its not dynamic .
        let body : [String : String] = [
            "email" : "eve.holt@reqres.in",
            "password" : "password"
        ]
        
        
        AF.request(LOGIN_URL,method: .post,parameters: body,encoder: JSONParameterEncoder.default).validate().response { res in
            switch res.result {
            case .success(let value):
                let json = JSON(value)
                print(json)
                completion(true)
                
            case .failure(let error):
                print(error)
                print(error.localizedDescription)
            }
            
            completion(false)
        }
    }
    
    
    
}
