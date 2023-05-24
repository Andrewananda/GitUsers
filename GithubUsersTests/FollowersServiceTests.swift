//
//  FollowersServiceTests.swift
//  GithubUsersTests
//
//  Created by Andrew Ananda on 24/05/2023.
//

import XCTest
@testable import GithubUsers

final class FollowersServiceTests: XCTestCase {
	
	let request = FollowerApiHandler()
	
	
	override func setUp() {
		super.setUp()
		
	}
	
	override func tearDown() {
		
		super.tearDown()
	}
	
	
	
	func testMakeRequest() {
		
		let urlRequest = request.makeRequest(from: [:], url: "").urlRequest
		
		XCTAssertEqual(urlRequest.httpMethod, "GET")
		XCTAssertNil(urlRequest.httpBody)
		
		XCTAssertEqual(urlRequest.url?.absoluteString, "\(K.Api.baseUrl + K.Api.users)/")
		XCTAssertNotNil(urlRequest.allHTTPHeaderFields)
		XCTAssertLessThanOrEqual(urlRequest.allHTTPHeaderFields!.count, 4)
	}
	
	
	func test401Response() {
		let sampleResponse =
		"""
		{
			"message": "Bad credentials",
			"documentation_url": "https://docs.github.com/rest"
		}
		"""
		let jsonData = sampleResponse.data(using: .utf8)!
		
		XCTAssertThrowsError(try request.parseResponse(data: jsonData))
		
		// or
		
		do {
			let _ = try request.parseResponse(data: jsonData)
			XCTFail()
		} catch let error as UnknownParseError {
			XCTAssertNotNil(error)
		} catch {
			XCTFail()
		}
	}
	
	
	func test200Response() {
		let sampleResponse =
		"""
		[
		  {
				  "login": "johnolwamba",
				  "id": 13263075,
				  "node_id": "MDQ6VXNlcjEzMjYzMDc1",
				  "avatar_url": "https://avatars.githubusercontent.com/u/13263075?v=4",
				  "gravatar_id": "",
				  "url": "https://api.github.com/users/johnolwamba",
				  "html_url": "https://github.com/johnolwamba",
				  "followers_url": "https://api.github.com/users/johnolwamba/followers",
				  "following_url": "https://api.github.com/users/johnolwamba/following{/other_user}",
				  "gists_url": "https://api.github.com/users/johnolwamba/gists{/gist_id}",
				  "starred_url": "https://api.github.com/users/johnolwamba/starred{/owner}{/repo}",
				  "subscriptions_url": "https://api.github.com/users/johnolwamba/subscriptions",
				  "organizations_url": "https://api.github.com/users/johnolwamba/orgs",
				  "repos_url": "https://api.github.com/users/johnolwamba/repos",
				  "events_url": "https://api.github.com/users/johnolwamba/events{/privacy}",
				  "received_events_url": "https://api.github.com/users/johnolwamba/received_events",
				  "type": "User",
				  "site_admin": false
			  }
		  ]
		"""
		let jsonData = sampleResponse.data(using: .utf8)!
		
		XCTAssertNoThrow(try request.parseResponse(data: jsonData))
		// or
		do {
			let response = try request.parseResponse(data: jsonData)
			XCTAssertEqual(response[0].login, "johnolwamba")
		} catch {
			XCTFail()
		}
	}
	
	func testUnknownError() {
		let sampleResponse =
		"""
		{
			"sample response"
		}
		"""
		let jsonData = sampleResponse.data(using: .utf8)!
		
		do {
			let _ = try request.parseResponse(data: jsonData)
			XCTFail()
		} catch let error as UnknownParseError {
			XCTAssertNotNil(error)
		} catch {
			XCTFail()
		}
		
	}

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
