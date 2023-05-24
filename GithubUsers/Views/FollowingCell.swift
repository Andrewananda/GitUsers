//
//  FollowingCell.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 22/05/2023.
//

import UIKit
import UIView_Shimmer

class FollowingCell: UICollectionViewCell, ShimmeringViewProtocol {
	
	@IBOutlet weak var icon: UIImageView!
	@IBOutlet weak var lblName: UILabel!
	
	
	var shimmeringAnimatedItems: [UIView] {
			[
				icon,
				lblName
			]
		}
	
	
	func loadData(data: FollowModel) {
		icon.loadImage(data.avatarURL, cornerRadius: 8)
		lblName.text = data.login
	}
    
}
