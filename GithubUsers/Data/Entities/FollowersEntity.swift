//
//  FollowersEntity.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 23/05/2023.
//

import Foundation
import RealmSwift

class FollowersEntity: Object {
	
	
	@objc dynamic var  login: String = ""
	@objc dynamic var  id: Int = 0
	@objc dynamic var  nodeID: String = ""
	@objc dynamic var  avatarURL: String = ""
	@objc dynamic var  gravatarID: String = ""
	@objc dynamic var  url: String = ""
	@objc dynamic var  htmlURL: String = ""
	@objc dynamic var  followersURL: String = ""
	@objc dynamic var  followingURL: String = ""
	@objc dynamic var  gistsURL: String = ""
	@objc dynamic var  starredURL: String = ""
	@objc dynamic var  subscriptionsURL: String = ""
	@objc dynamic var  organizationsURL: String = ""
	@objc dynamic var  reposURL: String = ""
	@objc dynamic var  eventsURL: String = ""
	@objc dynamic var  receivedEventsURL: String = ""
	@objc dynamic var  type: String = ""
	@objc dynamic var  siteAdmin: Bool = false
	
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	override static func indexedProperties() -> [String] {
		return ["id"]
	}
	
	
	convenience init(item: FollowModel) {
		self.init()
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

class FollowingEntity: Object {
	
	
	@objc dynamic var  login: String = ""
	@objc dynamic var  id: Int = 0
	@objc dynamic var  nodeID: String = ""
	@objc dynamic var  avatarURL: String = ""
	@objc dynamic var  gravatarID: String = ""
	@objc dynamic var  url: String = ""
	@objc dynamic var  htmlURL: String = ""
	@objc dynamic var  followersURL: String = ""
	@objc dynamic var  followingURL: String = ""
	@objc dynamic var  gistsURL: String = ""
	@objc dynamic var  starredURL: String = ""
	@objc dynamic var  subscriptionsURL: String = ""
	@objc dynamic var  organizationsURL: String = ""
	@objc dynamic var  reposURL: String = ""
	@objc dynamic var  eventsURL: String = ""
	@objc dynamic var  receivedEventsURL: String = ""
	@objc dynamic var  type: String = ""
	@objc dynamic var  siteAdmin: Bool = false
	
	
	override static func primaryKey() -> String? {
		return "id"
	}
	
	override static func indexedProperties() -> [String] {
		return ["id"]
	}
	
	convenience init(item: FollowModel) {
		self.init()
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
