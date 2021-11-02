//
//  WebAppCapabilityAction.swift
//  WebAppCapabilityAction
//
//  Created by Galym Kulyn on 06.09.2021.
//

import Foundation

extension WebApp.Capability {
	enum Action: String, Decodable {
		case showQrScanner = "show_qr_scanner"
		case showSmsDialog = "show_sms_dialog"
		case requestLocation = "request_location"
		case handleDeeplink = "handle_deeplink"
		// TODO: Exit?
	}
}
