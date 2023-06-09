//
//  MockService.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 24/05/2023.
//

import Foundation


class MockService {
	
	class func mockService(response: Data, completion: @escaping (URLSession) -> ()) {
		
		// Add MockURLProtocol to protocol classes
		let configuration = URLSessionConfiguration.ephemeral
		configuration.protocolClasses = [MockURLProtocol.self]
		let urlSession = URLSession(configuration: configuration)
		
		// request handler
		MockURLProtocol.requestHandler = { request in
			return (HTTPURLResponse(), response)
		}
		
		completion(urlSession)
	}
	
}
