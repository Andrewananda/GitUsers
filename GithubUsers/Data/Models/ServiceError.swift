//
//  ServiceError.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 24/05/2023.
//

import Foundation

struct ServiceError: Error, Codable {
	let message: String
	let documentation_url: String?
}
