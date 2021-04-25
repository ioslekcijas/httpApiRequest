//
//  GitHubUser.swift
//  GithubApiTest
//
//  Created by Armands Berzins on 31/03/2021.
//

import Foundation

// MARK: - GithubUser
struct GithubUser: Codable {
    let id: Int
    let avatarURL: String
    let name, company, bio: String

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
        case name, company, bio
    }
}
