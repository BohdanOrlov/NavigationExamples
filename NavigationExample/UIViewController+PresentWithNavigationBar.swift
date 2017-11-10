//
//  PresentationOptionsViewController.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

extension UIViewController {

    public func presentWithNavigationBar(_ controller: UIViewController, animated: Bool, completion: (() -> Void)?) {
        if let navigationController = self.navigationController {
            navigationController.pushViewController(controller, animated: animated, completion: completion)
        } else {
            let navigationController = UINavigationController(rootViewController: controller)
            self.present(navigationController, animated: animated, completion: completion)
            let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(userInitiatedDismiss))
            controller.navigationItem.leftBarButtonItem = button
        }
    }

    public func dismissRespectingNavigationBar(animated: Bool, completion: (() -> Void)?) {
        if let navigationController = self.navigationController {
                navigationController.popViewController(animated: animated, completion: completion)
        } else {
            self.dismiss(animated: animated, completion: completion)
        }
    }

    @objc private func userInitiatedDismiss() {
        self.dismissRespectingNavigationBar(animated: true, completion: nil)
    }
}

extension UINavigationController {

    public func pushViewController(_ viewController: UIViewController, animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }

    public func popViewController(animated: Bool, completion: (() -> Void)?) {
        CATransaction.begin()
        CATransaction.setCompletionBlock(completion)
        _ = self.popViewController(animated: animated)
        CATransaction.commit()
    }

}
