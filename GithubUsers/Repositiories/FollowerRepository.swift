//
//  FollowerRepository.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 22/05/2023.
//

import Foundation

struct FollowerApiHandler: APIHandler {
	
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
	
	func parseResponse(data: Data) throws -> [FollowModel] {
		return try defaultParseResponse(data: data)
	}
	
}


struct FollowerRepository {
	func fetchFollowers(parameters: [String: Any], query: String, completion: @escaping ([FollowModel]?, Error?) -> ()) {
		// api
		let api = FollowerApiHandler()
		// api loader
		let apiRequestLoader = APILoader(apiRequest: api)
		
		apiRequestLoader.loadAPIRequest(requestData: parameters, url: query) { (result, error) in
			completion(result, error)
		}
	}
	
	func fetchFollowing(parameters: [String: Any], query: String, completion: @escaping ([FollowModel]?, Error?) -> ()) {
		// api
		let api = FollowerApiHandler()
		// api loader
		let apiRequestLoader = APILoader(apiRequest: api)
		
		apiRequestLoader.loadAPIRequest(requestData: parameters, url: query) { (result, error) in
			completion(result, error)
		}
	}
}
