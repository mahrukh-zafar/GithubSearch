//
//  UserProfile.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import Foundation

struct UserProfile: Decodable{
    let avatar_url : String?
    let name : String?
    let followers : Int?
    let following : Int?
    let login : String?
    let message : String?
}
