//
//  ViewController.swift
//  WebAppRunner
//
//  Created by Galym Kulyn on 02.09.2021.
//

import WebKit

extension WebApp.Runner {
	final class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
		
		private let webApp: WebApp
		private let webAppStore: WebApp.Store
		private var progressBarView: UIProgressView!
		private var webView: WKWebView!
		
		var onViewDidLoad: (() -> Void)?
		
		// MARK: - Initializers
		
		init(webAppStore: WebApp.Store, webApp: WebApp) {
			self.webAppStore = webAppStore
			self.webApp = webApp
			super.init(nibName: nil, bundle: nil)
			
		}
		
		required init?(coder: NSCoder) {
			fatalError("init(coder:) has not been implemented")
		}
		
		// MARK: - Lifecycle
		
		override func loadView() {
			super.loadView()
			view = UIStackView().then {
				$0.axis = .vertical
				$0.addArrangedSubviews(
					UIProgressView(progressViewStyle: .bar).then {
						progressBarView = $0
						$0.translatesAutoresizingMaskIntoConstraints = false
						$0.heightAnchor.constraint(equalToConstant: 2).isActive = true
					},
					WKWebView(
						frame: .zero,
						configuration: {
							WKWebViewConfiguration().then {
								$0.websiteDataStore = .nonPersistent()
								$0.defaultWebpagePreferences = WKWebpagePreferences().then {
									$0.preferredContentMode = .mobile
									if #available(iOS 14.0, *) {
										$0.allowsContentJavaScript = true
									}
								}
							}
						}()
					).then {
						webView = $0
						$0.uiDelegate = self
						$0.navigationDelegate = self
						$0.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
					}
				)
			}
		}
		
		override func viewDidLoad() {
			super.viewDidLoad()
			onViewDidLoad?()
		}
		
		// MARK: - Misc
		
		private func validateWebAppAvailability() throws {
			guard webAppStore.webApps.contains(webApp) else {
				throw WebApp.Runner.CommonError.webAppNotFound(isFatal: true)
			}
		}
		
		func run() throws {
			try validateWebAppAvailability()
			webView.load(webApp.url.request)
		}
		
		// MARK: - ProgressBarView
		
		private func resetProgressBarViewProgress() {
			progressBarView.progress = 0
		}
		
		private func actualizeProgressBarViewProgress() {
			progressBarView.progress = Float(webView.estimatedProgress)
		}
		
		private func hideProgressBarView(_ isHidden: Bool) {
			UIView.animate(withDuration: 0.5) { self.progressBarView.isHidden = isHidden }
		}
		
		// MARK: - Notification
		
		override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
			guard case keyPath = UIProgressView.KeyPaths.estimatedProgress else { return }
			actualizeProgressBarViewProgress()
		}
		
		// MARK: - WKNavigationDelegate
		
		func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
			print(#function)
		}
		
		func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
			print(#function)
			hideProgressBarView(false)
		}
		
		func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
			print(#function)
			hideProgressBarView(true)
		}
		
		func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
			print(#function, error.localizedDescription)
		}
		
		func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
			print(#function, navigation)
		}
		
		func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
			print(#function, error.localizedDescription)
		}
		
		func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
			decisionHandler(.allow)
			print(#function, navigationResponse.response.url)
		}
		
		func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
			decisionHandler(.allow)
			print(#function, navigationAction.request.url, navigationAction.navigationType)
		}
		
		func webView(
			_ webView: WKWebView,
			decidePolicyFor navigationAction: WKNavigationAction,
			preferences: WKWebpagePreferences,
			decisionHandler: @escaping (WKNavigationActionPolicy, WKWebpagePreferences) -> Void
		) {
			preferences.preferredContentMode = .mobile
			decisionHandler(.allow, preferences)
			print(#function, navigationAction.request.url, navigationAction.navigationType)
		}
		
		func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
			print(#function)
		}
		
		func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
			print(#function)
		}
		
		func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
			print(#function)
		}
		
		func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
			print(#function)
			return nil
		}
		
		func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
			print(#function)
		}
		
		func webView(_ webView: WKWebView, contextMenuWillPresentForElement elementInfo: WKContextMenuElementInfo) {
			print(#function)
		}
		
	}
}
