//
//  ApiService.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 19/05/2023.
//

import Foundation


struct UnknownParseError: Error { let message: String }
struct NetworkError: Error {
	let message: String
}

//MARK: - Request handler
protocol RequestHandler {
	associatedtype RequestDataType
	func makeRequest(from data: RequestDataType, url: String) -> Request
}

protocol ResponseHandler {
	associatedtype ResponseDataType
	func parseResponse(data: Data) throws -> ResponseDataType
}

typealias APIHandler = RequestHandler & ResponseHandler

protocol RequestBuilder {
	func setHeaders(request: inout URLRequest)
}

class DefaultRequest: RequestBuilder {
	
	func setHeaders(request: inout URLRequest) {
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
	}
}

class AuthRequest: DefaultRequest {
	override func setHeaders(request: inout URLRequest) {
		
		super.setHeaders(request: &request)
		// Auth Headers
		let token = K.Api.token
		request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
	}
}

class Request {
	
	private var request: URLRequest
	
	init(urlRequest: URLRequest, requestBuilder: RequestBuilder) {
		self.request = urlRequest
		// do configuration
		requestBuilder.setHeaders(request: &self.request)
	}
	
	var urlRequest: URLRequest {
		return request
	}
}

extension RequestHandler {

	/// prepares httpbody
	func set(_ parameters: [String: Any], urlRequest: inout URLRequest) {
		// http body
		if parameters.count != 0 {
			if let jsonData = try? JSONSerialization.data(withJSONObject: parameters, options: []) {
				urlRequest.httpBody = jsonData
			}
		}
	}
}


// MARK: - Response
protocol Response: Codable {
//	var httpStatus: Int { set get }
}

extension ResponseHandler {
	/// generic response data parser
	func defaultParseResponse<T: Codable>(data: Data) throws -> T {

		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .useDefaultKeys
		do {
			return try jsonDecoder.decode(T.self, from: data)
		}catch(let error) {
			throw UnknownParseError(message: error.localizedDescription)
		}
	}
}


class APILoader<T: APIHandler> {
	
	let apiRequest: T
	
	let urlSession: URLSession
	
	let reachibility: Reachability
	
	
	
	init(apiRequest: T, urlSession: URLSession = .shared, reachibility: Reachability = Reachability()!) {
		self.apiRequest = apiRequest
		self.urlSession = urlSession
		self.reachibility = reachibility
	}
	
	func loadAPIRequest(requestData: T.RequestDataType, url: String,
						completionHandler: @escaping (T.ResponseDataType?, Error?) -> ()) {
		// check network status
		if reachibility.connection == .none {
			return completionHandler(nil, NetworkError(message: "No Internet Connection"))
		}

		// prepare url request
		let urlRequest = apiRequest.makeRequest(from: requestData, url: url).urlRequest
		// do session task
		urlSession.dataTask(with: urlRequest) { data, response, error in
			guard let data = data else { return completionHandler(nil, error) }
			
			do {
				let parsedResponse = try self.apiRequest.parseResponse(data: data)
				return completionHandler(parsedResponse, nil)
			} catch {
				return completionHandler(nil, error)
			}
		}.resume()
	}
}
