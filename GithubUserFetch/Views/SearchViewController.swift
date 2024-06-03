//
//  ViewController.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import UIKit
import SDWebImage

class SearchViewController: UIViewController {
    
    @IBOutlet weak var userTile: UIStackView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var notFoundLabel: UILabel!
    @IBOutlet weak var userAvatar: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    var userProfile : UserProfile?
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var followerLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        userTile.isHidden = true
        notFoundLabel.text = ""
        userTile.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(stackviewClicked)))
        
    }
    
    @objc func stackviewClicked() {
        let userProfileViewController = self.storyboard?.instantiateViewController(withIdentifier: "userProfileVC") as! UserProfileViewController
        userProfileViewController.user = userProfile
        navigationController?.pushViewController(userProfileViewController, animated: false)
    }
    
}

extension SearchViewController : UISearchBarDelegate{
    
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        
        if searchBar.text != ""{
            return true
        }else
        {
            searchBar.placeholder = "Artists, Songs or Podcasts"
            return false
        }
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let queryString = searchBar.text{
            if queryString.isEmpty{
                userTile.isHidden = true
                notFoundLabel.text = ""
            }
            
        }
        
    }
    
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let username = searchBar.text{
            let user = NetworkManager.shared.searchUser(urlString: "https://api.github.com/users/\(username)") {[self] user, error in
                if let user = user{
                   
                    if user.message != nil{
                        DispatchQueue.main.async {
                            self.notFoundLabel.text = user.message
                            userTile.isHidden = true
                        }
                        
                    }
                    else{
                        if let avatar = user.avatar_url {
                        let url = URL(string: avatar)
                        self.userAvatar.sd_setImage(with: url , placeholderImage: nil)
                        }
                        
                        DispatchQueue.main.async {
                            self.notFoundLabel.text = ""
                            self.userTile.isHidden = false
                            self.userNameLabel.text = "Username: \(user.login ?? "Not found")"
                            self.nameLabel.text = "Name: \(user.name ?? "Not found")"
                            self.followerLabel.text = "Followers: \(user.followers ?? 0)"
                            self.followingLabel.text = "Following: \(user.following ?? 0)"
                            userProfile = user
                            
                        }
                    }
                }
                else if let error = error{
                    print(error)
                }
               
            }
            
        }
    }
    
}
