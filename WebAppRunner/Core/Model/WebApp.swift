//
//  WebApp.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 02.09.2021.
//

import Foundation

struct WebApp: Decodable, Equatable {
	
	enum CodingKeys: String, CodingKey {
		case isDebug = "is_debug"
		case name
		case url
		case capability
	}
	
	let name: String
	let url: URL
	let isDebug: Bool
	let capability: Capability?
	
	init(from decoder: Decoder) throws {
		let container = try decoder.container(keyedBy: CodingKeys.self)
		name = try container.decode(String.self, forKey: .name)
		url = try container.decode(URL.self, forKey: .url)
		isDebug = try container.decodeIfPresent(Bool.self, forKey: .isDebug) ?? false
		capability = try container.decodeIfPresent(Capability.self, forKey: .capability)
	}
	
	// MARK: Equatable
	
	static func ==(lhs: WebApp, rhs: WebApp) -> Bool {
		guard let lhsHost = lhs.url.host, let rhsHost = rhs.url.host else {
			return false
		}
		return lhsHost == rhsHost
	}
	
}
