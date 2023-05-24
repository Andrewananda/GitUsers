//
//  ViewController.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 19/05/2023.
//

import UIKit
import RxSwift



class ViewController: UIViewController {
	
	@IBOutlet private weak var lblFollowing: UILabel!
	@IBOutlet private weak var lblFollowers: UILabel!
	@IBOutlet private weak var lblRepos: UILabel!
	@IBOutlet private weak var lblUsername: UILabel!
	@IBOutlet private weak var lblName: UILabel!
	@IBOutlet private weak var lblBio: UILabel!
	@IBOutlet private weak var lblLocation: UILabel!
	@IBOutlet private weak var icon: UIImageView!
	@IBOutlet weak var followingCollectionView: UICollectionView!
	@IBOutlet weak var followersCollectionView: UICollectionView!
	

	
	//MARK: properties
	private var searchBar = UISearchBar()
	private var searchBarButtonItem: UIBarButtonItem?
	private var disposeBag = DisposeBag()
	private var followersArr =  [FollowModel]()
	private var followingArr =  [FollowModel]()
	
	private lazy var viewModel: UserViewModel = {
		let viewModel = UserViewModel()
		return viewModel
	}()

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
		
		showMessageView()
		observers()
		configVC()
	}

	private let messageView: MessageView = {
		let view = MessageView()
		view.translatesAutoresizingMaskIntoConstraints = false
		view.backgroundColor = .systemBackground
		return view
	}()
	
	private func showMessageView(message: String = "Search for git repo") {
		DispatchQueue.main.async {
			self.view.addSubview(self.messageView)
			self.messageView.lblMessage.text = message
			
			
			NSLayoutConstraint.activate([
				self.messageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
				self.messageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
				self.messageView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
				self.messageView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
			])
			
			
		}
	}
	
	func hideMessageView() {
		self.messageView.removeFromSuperview()
	}
	
	private func configVC() {
		searchBar.delegate = self
		searchBar.searchBarStyle = UISearchBar.Style.minimal
		searchBarButtonItem = navigationItem.rightBarButtonItem
		
		[followersCollectionView, followingCollectionView].forEach({
			$0?.dataSource = self
			$0?.delegate = self
		})
		
		viewModel.checkForLocalData()
	}
	
	
	private func observers() {
		viewModel.userResponse.subscribe(onNext: { res in
			DispatchQueue.main.async {
				self.lblFollowers.text = "\(res?.followers ?? 0) \n followers"
				self.lblFollowing.text = "\(res?.following ?? 0) \n following"
				self.lblRepos.text = "\(res?.repos ?? 0) \n repos"
				self.lblName.text = res?.name ?? ""
				self.lblUsername.text = res?.login ?? ""
				self.lblBio.text = res?.bio ?? ""
				self.lblLocation.text = res?.location ?? ""
				self.icon.loadImage(res?.avatarURL ?? ""
									, cornerRadius: 8)
				
				self.viewModel.fetchFollowers(parameters: [:], query: "\(res?.login ?? "" )/followers")
				self.viewModel.fetchFollowing(parameters: [:], query: "\(res?.login ?? "" )/following")
				self.hideMessageView()
			}
		}).disposed(by: disposeBag)
		
		viewModel.followerResponse.subscribe(onNext: {res in
			self.followersArr.removeAll()
			self.followersArr.append(contentsOf: res ?? [])
			DispatchQueue.main.async {
				self.followersCollectionView.reloadData()
			}
		}).disposed(by: disposeBag)
		
		viewModel.followingResponse.subscribe(onNext: {res in
			self.followingArr.removeAll()
			self.followingArr.append(contentsOf: res ?? [])
			DispatchQueue.main.async {
				self.followingCollectionView.reloadData()
			}
		}).disposed(by: disposeBag)
		
		viewModel.errorResponse.subscribe(onNext: {error in
			self.showMessageView(message: error?.localizedDescription ?? "")
		}).disposed(by: disposeBag)
		
		
		
	}

}



//MARK:  - search
extension ViewController: UISearchBarDelegate {
	
	@IBAction func searchButtonPressed(sender: AnyObject) {
		showSearchBar()
	  }
	
	func showSearchBar() {
		searchBar.alpha = 0
		navigationItem.titleView = searchBar
		searchBar.showsCancelButton = true
		searchBar.placeholder = "Search"
		navigationItem.setLeftBarButton(nil, animated: true)
		if #available(iOS 16.0, *) {
			searchBarButtonItem?.isHidden = true
		}
		
		UIView.animate(withDuration: 0.5, animations: {
		  self.searchBar.alpha = 1
		  }, completion: { finished in
			self.searchBar.becomeFirstResponder()
		})
	  }
	
	
	func hideSearchBar() {
		navigationItem.setRightBarButton(searchBarButtonItem, animated: true)
		searchBar.showsCancelButton = false
		if #available(iOS 16.0, *) {
			searchBarButtonItem?.isHidden = false
		}
		
		UIView.animate(withDuration: 0.3, animations: {
			self.navigationItem.titleView = nil
			self.searchBar.resignFirstResponder()
			self.searchBar.alpha = 0
			  }, completion: { finished in

			})
	  
	}
	
	func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
		hideSearchBar()
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		if ((searchBar.text?.isEmpty) != nil) {
			self.hideMessageView()
			searchForUser(login: searchBar.text!)
			searchBar.text = ""
			hideSearchBar()
		}
	}
	
}


//Dispay userdata
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		if collectionView == followersCollectionView {
			return followersArr.count
		}else {
			return followingArr.count
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		if collectionView == followersCollectionView {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followersCell", for: indexPath) as! FollowingCell
			cell.loadData(data: followersArr[indexPath.row])
			return cell
		}else {
			let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "followingCell", for: indexPath) as! FollowingCell
			cell.loadData(data: followingArr[indexPath.row])
			return cell
		}
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		if collectionView == followersCollectionView {
			let data = followersArr[indexPath.row]
			searchForUser(login: data.login)
		}else {
			let data = followingArr[indexPath.row]
			searchForUser(login: data.login)
		}
	}
	
	
	func searchForUser(login: String) {
		viewModel.fetchUsers(parameters: [:], query: login)
		self.showMessageView(message: "Searching......")
	}
	
}
