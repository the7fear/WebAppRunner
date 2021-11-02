//
//  WebAppRunnerError.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 03.09.2021.
//

import Foundation

extension WebApp.Runner {
	// Ошибки модуля WebAppRunner.
	enum CommonError: Error, CustomStringConvertible, LocalizedError {
		// Throw when expected web app not found in the web app store. Can be marked as fatal if you assume that is unrecoverable.
		// Бросаем ошибку если ожидаемый web app не найден в web app store. Можно отметить как fatal если предпологаете непоправимым.
		case webAppNotFound(isFatal: Bool)
		
		// Throw when expected web app host can't build URL. Can be marked as fatal if you assume that is unrecoverable.
		// Бросаем ошибку если web app host не может построить URL. Можно отметить как fatal если предпологаете непоправимым.
		case webAppBadUrl(isFatal: Bool)
		
		// TODO: Нужно или можно дополнить ошибки...
		
		// Фатальность ошибок, можно дополнить...
		var isFatal: Bool {
			switch self {
			case .webAppNotFound(let isFatal):
				return isFatal
			default:
				return false
			}
		}
		
		// MARK: - CustomStringConvertible
		
		var description: String {
			switch self {
			case .webAppNotFound:
				return "The provided web app not found in WebAppStore."
			case .webAppBadUrl:
				return "Failed to build web app URL"
			}
		}
		
		// MARK: - LocalizedError
		
		public var errorDescription: String? {
			switch self {
			case .webAppNotFound:
				return NSLocalizedString(
					"The specified web app could not be found in WebAppStore.",
					comment: "Web App Not Found"
				)
			case .webAppBadUrl:
				return NSLocalizedString(
					"Failed to build web app URL",
					comment: "URL not correct"
				)
			}
		}
	}
}
