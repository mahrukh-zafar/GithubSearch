//
//  UserProfileViewController.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import UIKit

class UserProfileViewController: UIViewController {
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var nameLab: UILabel!
    var user: UserProfile?
    @IBOutlet weak var followingButton: UIButton!
    @IBOutlet weak var followers: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let user = user{

        nameLab.text = "Name: \(user.name ?? "Not found")"
        username.text = "Username: \(user.login ?? "Not found")"
        followers.setTitle("\(user.followers ?? 0)", for: .normal)
        followingButton.setTitle("\(user.following ?? 0)", for: .normal)
        }
       
    }
    
   
    @IBAction func followerButtonPressed(_ sender: Any) {
        
        print("I am here")
        guard let username = user?.login else{return}
        print(username)
        NetworkManager.shared.searchFollowers(urlString: "https://api.github.com/users/\(username)/followers") { users, error in

            DispatchQueue.main.async{
                
                let followersTableView = FollowersTableViewController()
            followersTableView.followers = users
            self.navigationController?.pushViewController(followersTableView, animated: false)
                
                
            }
        }
    }
    
    @IBAction func FollowingButtonPressed(_ sender: Any) {
        
        guard let username = user?.login else{return}
        print(username)
        NetworkManager.shared.searchFollowers(urlString: "https://api.github.com/users/\(username)/following") { users, error in

            DispatchQueue.main.async{
                
                let followersTableView = FollowersTableViewController()
            followersTableView.followers = users
            self.navigationController?.pushViewController(followersTableView, animated: false)
                
                
            }
        }
    }
}
