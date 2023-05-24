//
//  UserRepository.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 20/05/2023.
//

import Foundation


struct UserApiHandler: APIHandler {
	
	func makeRequest(from parameters: [String: Any], url: String) -> Request {
		// url components
		var components = URLComponents(string: "\(K.Api.baseUrl + K.Api.users + "/" + url)" )!
		var queryItems = [URLQueryItem]()
		for (key, value) in parameters {
			queryItems.append(URLQueryItem(name: key, value: "\(value)"))
		}
		if parameters.count > 0 {
			components.queryItems = queryItems
		}
		// url request
		let url = components.url
		var urlRequest = URLRequest(url: url!)
		urlRequest.httpMethod = "GET"
		let request = Request(urlRequest: urlRequest, requestBuilder: AuthRequest())
		return request
	}
	
	func parseResponse(data: Data) throws -> UserModel {
		return try defaultParseResponse(data: data)
	}
	
}


struct UserRepository {
	func getUsers(parameters: [String: Any], query: String, completion: @escaping (UserModel?, Error?) -> ()) {
		// api
		let api = UserApiHandler()
		// api loader
		let apiRequestLoader = APILoader(apiRequest: api)
		
		apiRequestLoader.loadAPIRequest(requestData: parameters, url: query) { (result, error) in
			completion(result, error)
		}
	}
}
