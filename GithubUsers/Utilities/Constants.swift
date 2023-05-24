//
//  Constants.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 20/05/2023.
//

import Foundation


struct K {
	struct Api {
		static let baseUrl = "https://api.github.com/"
		static let users = "users"
		static let userFollowers = "user/followers"
		static let token = ""
	}
}


enum MessageType {
	case search
	case notFound
	case noNetworkConnection
}
