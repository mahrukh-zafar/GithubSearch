//
//  NetworkManager.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    func searchUser(urlString: String, onComplete: @escaping (UserProfile?, Error?) -> Void){
        var user : UserProfile?
        var userURL = urlString
        print(urlString)
        if let url = URL(string: userURL){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
               
                if let error = error{
                    print(error)
                }else if let data = data{
                    print(data.description)
                    
                    do {
                         user = try JSONDecoder().decode(UserProfile.self, from: data)
                        
                        
                    } catch {
                        print(error)
                        
                    }
                    
                    onComplete(user, error)
                    
                }
                
            }
            task.resume()
        }
     
    }
    
    func searchFollowers(urlString: String, onComplete: @escaping ([UserProfile], Error?) -> Void){
        var user =  [UserProfile]()
        var userURL = urlString
        print(urlString)
        if let url = URL(string: urlString){
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
               
                if let error = error{
                    print(error)
                }else if let data = data{
                    print(data.description)
                    
                    do {
                         user = try JSONDecoder().decode([UserProfile].self, from: data)
                        
                        print(user)
                    } catch {
                        print(error)
                        
                    }
                    onComplete(user, error)
                }
                
            }
            task.resume()
        }
     
    }
   
    
}
