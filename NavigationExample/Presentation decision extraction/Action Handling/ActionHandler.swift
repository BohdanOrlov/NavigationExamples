//
//  ActionHandler.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class ActionHandler: ActionHandling {
    private let presenterProvider: () -> ViewControllerPresenting
    private let detailsControllerProvider: (String, @escaping () -> Void) -> UIViewController
    init(presenterProvider: @escaping () -> UIViewController, detailsControllerProvider: @escaping (String, @escaping () -> Void) -> UIViewController) {
        self.presenterProvider = presenterProvider
        self.detailsControllerProvider = detailsControllerProvider
    }
    func handleAction(for detailText: String) {
        let viewController = detailsControllerProvider(detailText) { [weak self] in
            self?.presenterProvider().dismiss(animated: true, completion: nil)
        }
        presenterProvider().present(viewController, animated: true, completion: nil)
    }
}
