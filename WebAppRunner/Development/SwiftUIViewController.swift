//
//  SwiftUIViewController.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 02.09.2021.
//

import SwiftUI

struct SwiftUIViewController: UIViewControllerRepresentable {
	typealias UIViewControllerType = WebApp.Runner.ViewController
	func makeUIViewController(context: Context) -> WebApp.Runner.ViewController {
		WebApp.Runner.ViewController(
			webAppStore: localWebAppStore,
			webApp: localWebAppStore.webApps.first { webApp in webApp.name == "AsterTest" }!
		).then { viewController in
			viewController.onViewDidLoad = {
				do {
					try viewController.run()
				} catch let webAppRunnerError {
					print(webAppRunnerError.localizedDescription)
				}
			}
		}
	}
	
	func updateUIViewController(_ uiViewController: WebApp.Runner.ViewController, context: Context) {
		
	}
	
	private var localWebAppStore: WebApp.Store {
		let jsonDecoder = JSONDecoder()
		jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
		do {
			return try jsonDecoder.decode(
				WebApp.Store.self,
				from: Data(
					contentsOf: Bundle.main.url(
						forResource: "WebAppStore",
						withExtension: "json"
					)!
				)
			)
		} catch {
			print(error)
			fatalError("Web store can't initialize: \(error.localizedDescription)")
		}
	}
}
