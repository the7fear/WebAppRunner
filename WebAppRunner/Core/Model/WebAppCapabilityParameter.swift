//
//  WebAppCapabilityParameter.swift
//  WebAppCapabilityParameter
//
//  Created by Galym Kulyn on 07.09.2021.
//

import Foundation

extension WebApp.Capability {
	enum Parameter: String, Decodable {
		case colorMode = "color_mode"
		case language
	}
}
