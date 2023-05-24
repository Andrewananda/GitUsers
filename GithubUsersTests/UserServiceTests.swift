//
//  UserServiceTests.swift
//  GithubUsersTests
//
//  Created by Andrew Ananda on 24/05/2023.
//

import XCTest
@testable import GithubUsers

final class UserServiceTests: XCTestCase {
	
	let request = UserApiHandler()
	
	
	
	func test200Response() {
		let sampleResponse =
		"""
			  {
					"login": "Andrewananda",
					"id": 35327893,
					"node_id": "MDQ6VXNlcjM1122I3ODkz",
					"avatar_url": "https://avatars.githubusercontent.com/u/35327893?v=4",
					"gravatar_id": "",
					"url": "https://api.github.com/users/Andrewananda",
					"html_url": "https://github.com/Andrewananda",
					"followers_url": "https://api.github.com/users/Andrewananda/followers",
					"following_url": "https://api.github.com/users/Andrewananda/following{/other_user}",
					"gists_url": "https://api.github.com/users/Andrewananda/gists{/gist_id}",
					"starred_url": "https://api.github.com/users/Andrewananda/starred{/owner}{/repo}",
					"subscriptions_url": "https://api.github.com/users/Andrewananda/subscriptions",
					"organizations_url": "https://api.github.com/users/Andrewananda/orgs",
					"repos_url": "https://api.github.com/users/Andrewananda/repos",
					"events_url": "https://api.github.com/users/Andrewananda/events{/privacy}",
					"received_events_url": "https://api.github.com/users/Andrewananda/received_events",
					"type": "User",
					"site_admin": false,
					"name": "Andrew Ananda",
					"company": null,
					"blog": "www.devstart.co.ke",
					"location": "Nairobi",
					"email": null,
					"hireable": null,
					"bio": "Ios | ReactNative",
					"twitter_username": "andrewananda",
					"public_repos": 61,
					"public_gists": 0,
					"followers": 12,
					"following": 54,
					"created_at": "2018-01-11T08:12:44Z",
					"updated_at": "2023-05-15T19:58:17Z",
					"private_gists": 0,
					"total_private_repos": 33,
					"owned_private_repos": 33,
					"disk_usage": 1327086,
					"collaborators": 5,
					"two_factor_authentication": false,
					"plan": {
						"name": "free",
						"space": 976562499,
						"collaborators": 0,
						"private_repos": 10000
					}
				}
		"""
		let jsonData = sampleResponse.data(using: .utf8)!
		
		XCTAssertNoThrow(try request.parseResponse(data: jsonData))
		// or
		do {
			let response = try request.parseResponse(data: jsonData)
			XCTAssertEqual(response.login, "Andrewananda")
		} catch {
			XCTFail()
		}
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
