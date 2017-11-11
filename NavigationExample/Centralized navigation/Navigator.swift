//
//  Navigator.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 11/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

public protocol Navigating {
    func handlePush()
}

final class Navigator: Navigating {
    func handlePush() {
        guard self.hasNoBlockingViewController() else { return }
        self.dismissAll { [weak self] in
            self?.presentTwoDetailsControllers()
        }
    }

    init(navigationController: UINavigationController, controllerForDetailsProvider: @escaping (_ detailsText: String, _ didFinish: @escaping Completion) -> UIViewController) {
        self.navigationController = navigationController
        self.controllerForDetailsProvider = controllerForDetailsProvider

    }

    private func dismissAll(completion: @escaping Completion) {
        let popAndPresent = { [weak self] in
            self?.navigationController.popToRootViewController(animated: true)
            completion()
        }
        if self.navigationController.topViewController?.presentedViewController != nil {
            self.navigationController.topViewController?.dismiss(animated: true) {
                popAndPresent()
            }
        } else {
            popAndPresent()
        }
    }

    private func presentTwoDetailsControllers() {
        let viewController = self.controllerForDetailsProvider("My details") { [weak self] in
            self?.navigationController.dismissRespectingNavigationBar(animated: true, completion: nil)
        }
        self.navigationController.presentWithNavigationBar(viewController, animated: true, completion: {
            [weak self] in
            guard let sSelf = self else { return }
            let viewController2 = sSelf.controllerForDetailsProvider("My another details") { [weak viewController] in
                viewController?.dismissRespectingNavigationBar(animated: true, completion: nil)
            }
            viewController.presentWithNavigationBar(viewController2, animated: true, completion: nil)
        })
    }

    private func hasNoBlockingViewController() -> Bool {
        // return false if any VC in hierarchy is considered to be a blocking VC
        return true
    }

    private var controllerForDetailsProvider: (_ detailsText: String, _ didFinish: @escaping Completion) -> UIViewController
    private let navigationController: UINavigationController
}
