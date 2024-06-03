//
//  FollowersTableViewController.swift
//  GithubUserFetch
//
//  Created by Dev on 31/05/2024.
//

import UIKit

class FollowersTableViewController: UITableViewController {
    
    var followers: [UserProfile]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        self.tableView.register(UINib(nibName: "FollowersTableViewCell", bundle: nil), forCellReuseIdentifier: "followersCell")

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let followers = followers else{return 0}
        print(followers.count)
        return followers.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "followersCell") as! FollowersTableViewCell
       
        cell.usernameLabel.text = followers![indexPath.row].login
        if let avatar = followers![indexPath.row].avatar_url {
            let url = URL(string: avatar)
                cell.avatar.sd_setImage(with: url , placeholderImage: nil)
            }
          
                return cell
           
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("I was clicked")
        
        let followerProfileView = FollowerProfileViewController()
        followerProfileView.username = followers![indexPath.row].login
        navigationController?.pushViewController(followerProfileView, animated: false)
    }


}
