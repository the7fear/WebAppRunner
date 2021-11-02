//
//  Permission.swift
//  Permission
//
//  Created by Galym Kulyn on 06.09.2021.
//

import Foundation

extension WebApp {
	struct Capability: Decodable {
		let parameters: [Parameter]
		let actions: [Action]
	}
}
