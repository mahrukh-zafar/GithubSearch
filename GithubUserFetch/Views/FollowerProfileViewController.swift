//
//  FollowerProfileViewController.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import UIKit
import SDWebImage

class FollowerProfileViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatar: UIImageView!
    var username: String?
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let username = username else{return}
        NetworkManager.shared.searchUser(urlString: "https://api.github.com/users/\(username)") { [self] user, error in

            print("i am in follower profile")
            if let user = user{
                DispatchQueue.main.async{ [self] in
                    usernameLabel.text = user.login  ?? "Not found"
                nameLabel.text = user.name ?? "Not found"
                    
                }
                if let avatarURL = user.avatar_url {
                let url = URL(string: avatarURL)
                    avatar.sd_setImage(with: url)
                }

            }
        }
       
    }
   


}
