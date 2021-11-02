//
//  WebAppStore.swift
//  WebAppStore
//
//  Created by Galym Kulyn on 07.09.2021.
//

import Foundation

extension WebApp {
	struct Store: Decodable {
		let version: String
		let webApps: [WebApp]
	}
}
