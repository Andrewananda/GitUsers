//
//  MessageView.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 23/05/2023.
//

import Foundation
import UIKit


class MessageView: UIView {
	
	lazy var imageView: UIImageView = {
		let imageView = UIImageView()
		imageView.translatesAutoresizingMaskIntoConstraints = false
		imageView.image = UIImage(named: "search_image")
		imageView.contentMode = .scaleAspectFit
		return imageView
	}()
	
	lazy var lblMessage: UILabel = {
		let message = UILabel()
		message.translatesAutoresizingMaskIntoConstraints = false
		message.numberOfLines = 0
		return message
	}()
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		setupView()
	}

	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setupView()
	}
	
	
	private func setupView() {
		self.addSubview(imageView)
		self.addSubview(lblMessage)
		imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
		imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
		lblMessage.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 100).isActive = true
		lblMessage.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
	}
	
}
