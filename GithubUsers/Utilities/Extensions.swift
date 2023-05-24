//
//  Extensions.swift
//  GithubUsers
//
//  Created by Andrew Ananda on 22/05/2023.
//

import Foundation
import UIKit
import Kingfisher
import RealmSwift

extension UIImageView {
	func loadImage(_ imgUri: String, cornerRadius: CGFloat = 0) {
		self.setNeedsLayout()
		self.layoutIfNeeded()
		let url = URL(string: imgUri)
		let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
		self.kf.indicatorType = .activity
		self.kf.setImage(
			with: url,
			placeholder: nil,
			options: [
				.processor(processor),
				.scaleFactor(UIScreen.main.scale),
				.transition(.fade(1)),
				.cacheOriginalImage
			], completionHandler: {
				result in
				switch result {
				case .success( _):
					// print("Task done for: \(value.source.url?.absoluteString ?? "")")
					break
				case .failure(let error):
					print("Job failed: \(error.localizedDescription) url: \(imgUri)")
					break
				}
			})
	}
	
	func loadImage(_ imgUri: String, cornerRadius: CGFloat = 0, placeholder: String) {
		self.setNeedsLayout()
		self.layoutIfNeeded()
		let url = URL(string: imgUri)
		let processor = DownsamplingImageProcessor(size: self.bounds.size) |> RoundCornerImageProcessor(cornerRadius: cornerRadius)
		self.kf.indicatorType = .activity
		self.kf.setImage(
			with: url,
			placeholder: UIImage(named: placeholder),
			options: [
				.processor(processor),
				.scaleFactor(UIScreen.main.scale),
				.transition(.fade(1)),
				.cacheOriginalImage
			], completionHandler: {
				result in
				switch result {
				case .success( _):
					// print("Task done for: \(value.source.url?.absoluteString ?? "")")
					break
				case .failure(let error):
					print("Job failed: \(error.localizedDescription) url: \(imgUri)")
					break
				}
			})
	}
}



@IBDesignable
extension UIView {
	@IBInspectable
	public var cornerRadius: CGFloat
	{
		set (radius) {
			self.layer.cornerRadius = radius
			self.layer.masksToBounds = radius > 0
		}
		
		get {
			return self.layer.cornerRadius
		}
	}
}


extension Results {
	func toArray() -> [Element] {
		return compactMap { $0 }
	}
}
