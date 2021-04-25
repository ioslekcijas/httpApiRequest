//
//  ViewController.swift
//  GithubApiTest
//
//  Created by Armands Berzins on 31/03/2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var contentContainer: UIView!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchGitHubUser()
    }

    func fetchGitHubUser() {
        
        let url = URL(string: "https://api.github.com/users/ioslekcijas")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let urlTask = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let data = data {
                if let githubUser = try? JSONDecoder().decode(GithubUser.self, from: data) {
                    
                    DispatchQueue.main.async {
                        self.onDownloaded(githubUser)
                    }
                    return
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        urlTask.resume()
    }
    
    func onDownloaded(_ userData: GithubUser) {
        nameLabel.text = userData.name
        companyNameLabel.text = userData.company
        bioTextView.text = userData.bio
        profileImageView.downloaded(from: userData.avatarURL)
        
        contentContainer.isHidden = false
        activityIndicator.stopAnimating()
    }

}

