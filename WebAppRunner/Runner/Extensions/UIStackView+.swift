//
//  UIStackView+.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 03.09.2021.
//

import UIKit

extension UIStackView {
	func addArrangedSubviews(_ views: UIView...) {
		views.forEach { addArrangedSubview($0) }
	}
}
