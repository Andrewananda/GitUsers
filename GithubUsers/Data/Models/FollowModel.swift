//
//  FollowModel.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 22/05/2023.
//

import Foundation

struct FollowModel: Response {
	let login: String
	let id: Int
	let nodeID: String
	let avatarURL: String
	let gravatarID: String
	let url, htmlURL, followersURL: String
	let followingURL, gistsURL, starredURL: String
	let subscriptionsURL, organizationsURL, reposURL: String
	let eventsURL: String
	let receivedEventsURL: String
	let type: String
	let siteAdmin: Bool
	
	enum CodingKeys: String, CodingKey {
		case login, id
		case nodeID = "node_id"
		case avatarURL = "avatar_url"
		case gravatarID = "gravatar_id"
		case url
		case htmlURL = "html_url"
		case followersURL = "followers_url"
		case followingURL = "following_url"
		case gistsURL = "gists_url"
		case starredURL = "starred_url"
		case subscriptionsURL = "subscriptions_url"
		case organizationsURL = "organizations_url"
		case reposURL = "repos_url"
		case eventsURL = "events_url"
		case receivedEventsURL = "received_events_url"
		case type
		case siteAdmin = "site_admin"
	}
	
	init(item: FollowersEntity) {
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
	}
	
	init(item: FollowingEntity) {
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
	}
}
