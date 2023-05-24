//
//  UserModel.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 20/05/2023.
//

import Foundation


struct UserModel: Response {
	
	var login: String
	var id: Int
	var nodeID: String
	var avatarURL: String
	var gravatarID: String
	var url, htmlURL, followersURL: String
	var followers, following, repos : Int
	var followingURL, gistsURL, starredURL: String
	var subscriptionsURL, organizationsURL, reposURL: String
	var eventsURL: String
	var name: String
	var receivedEventsURL: String
	var type, bio, location: String?
	var siteAdmin: Bool
	
		
	
	
		enum CodingKeys: String, CodingKey {
			case login, id, name
			case followers, following
			case nodeID = "node_id"
			case avatarURL = "avatar_url"
			case gravatarID = "gravatar_id"
			case url
			case htmlURL = "html_url"
			case repos = "public_repos"
			case followersURL = "followers_url"
			case followingURL = "following_url"
			case gistsURL = "gists_url"
			case starredURL = "starred_url"
			case subscriptionsURL = "subscriptions_url"
			case organizationsURL = "organizations_url"
			case reposURL = "repos_url"
			case eventsURL = "events_url"
			case receivedEventsURL = "received_events_url"
			case type, bio, location
			case siteAdmin = "site_admin"
		}
	
	
	
	init(item: UserEntity) {
		self.login = item.login
		self.id = item.id
		self.nodeID = item.nodeID
		self.avatarURL = item.avatarURL
		self.gravatarID = item.gravatarID
		self.url = item.url
		self.htmlURL = item.htmlURL
		self.followersURL = item.followersURL
		self.followingURL = item.followingURL
		self.gistsURL = item.gistsURL
		self.starredURL = item.starredURL
		self.subscriptionsURL = item.subscriptionsURL
		self.organizationsURL = item.organizationsURL
		self.reposURL = item.reposURL
		self.eventsURL = item.eventsURL
		self.receivedEventsURL = item.receivedEventsURL
		self.type = item.type
		self.siteAdmin = item.siteAdmin
		self.name = item.name
		self.bio = item.bio
		self.location = item.location
		self.repos = item.repos
		self.following = item.following
		self.followers = item.followers
	}
	
}
