//
//  InlineConfigurable.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 02.09.2021.
//

import Foundation

public protocol InlineConfigurable {}

public extension InlineConfigurable {
	@discardableResult func then(_ handler: (Self) -> Void) -> Self {
		handler(self)
		return self
	}
}
