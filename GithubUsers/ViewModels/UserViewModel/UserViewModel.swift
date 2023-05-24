//
//  UserViewModel.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 20/05/2023.
//

import Foundation
import RxSwift
import RxRelay

class UserViewModel {
	
	
	private var userRepository: UserRepository
	private var dbManager: DbManager
	private var followerRepository: FollowerRepository
	public var userResponse = PublishRelay<UserModel?>()
	public var followerResponse = PublishRelay<[FollowModel]?>()
	public var followingResponse = PublishRelay<[FollowModel]?>()
	public var errorResponse = PublishRelay<Error?>()
	
	
	init() {
		self.userRepository = UserRepository()
		self.followerRepository = FollowerRepository()
		self.dbManager = DbManager()
	}
	
	func fetchUsers(parameters: [String: Any], query: String) {
		userRepository.getUsers(parameters: parameters, query: query) { (response, error) in
			if error != nil {
				self.errorResponse.accept(error)
			}else {
				if response != nil {
					let data = UserEntity(item: response!)
					DispatchQueue.main.async {
						self.dbManager.saveUsers(data)
					}
					self.userResponse.accept(response)
				}
			}
			
		}
		
	}
	
	
	func checkForLocalData() {
		let user = dbManager.getUsers().toArray().first
		if user != nil {
			let data = UserModel(item: user!)
			self.userResponse.accept(data)
		}
		
		let followers = dbManager.getFollowers().toArray()
		if followers.count != 0 {
			let entities = followers.map { item in
				FollowModel(item: item)
			}
			self.followerResponse.accept(entities)
		}
		
		
		let followings = dbManager.getFollowing().toArray()
		if followings.count != 0 {
			let entities = followings.map { item in
				FollowModel(item: item)
			}
			self.followingResponse.accept(entities)
		}
		
		
	}
	
	
	func fetchFollowers(parameters: [String: Any], query: String) {
		followerRepository.fetchFollowers(parameters: parameters, query: query) { res, error in
			if error != nil {
				self.errorResponse.accept(error)
			}else {
				
				if res != nil {
					
					var entities = [FollowersEntity]()
					res?.forEach({ item in
						entities.append(FollowersEntity(item: item))
					})
					
					DispatchQueue.main.async {
						self.dbManager.saveFollowers(entities)
					}
					self.followerResponse.accept(res)
				}
				
				
			}
		}
	}
	
	func fetchFollowing(parameters: [String: Any], query: String) {
		followerRepository.fetchFollowing(parameters: parameters, query: query) { res, error in
			if error != nil {
				self.errorResponse.accept(error)
			}else {
				self.followingResponse.accept(res)
				
				if res != nil {
					
					var entities = [FollowingEntity]()
					res?.forEach({ item in
						entities.append(FollowingEntity(item: item))
					})
					
					DispatchQueue.main.async {
						self.dbManager.saveFollowing(entities)
					}
					self.followingResponse.accept(res)
				}
				
				
			}
		}
	}
	
}
