// SceneDelegate.swift
// Copyright © Taras Kotsur. All rights reserved.

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    // MARK: - Public properties

    var window: UIWindow?
    var applicationCoorinator: ApplicationCoordiantorProtocol?

    // MARK: - Methods

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        applicationCoorinator = ApplicationCoordiantor(window: window)
        applicationCoorinator?.start()
    }
}
