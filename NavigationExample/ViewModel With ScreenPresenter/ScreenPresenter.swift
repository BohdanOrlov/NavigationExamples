//
//  ScreenPresenter.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class ScreenPresenter: ScreenPresenting {
    private let presenterProvider: () -> ViewControllerPresenting
    private let detailsControllerProvider: (String, @escaping () -> Void) -> UIViewController
    init(presenterProvider: @escaping () -> UIViewController, detailsControllerProvider: @escaping (String, @escaping () -> Void) -> UIViewController) {
        self.presenterProvider = presenterProvider
        self.detailsControllerProvider = detailsControllerProvider
    }

    func presentScreen(for detailText: String, didFinish: @escaping () -> Void) {
        presenterProvider().present(detailsControllerProvider(detailText, didFinish), animated: true, completion: nil)
    }

    func dismissScreen() {
        presenterProvider().dismiss(animated: true, completion: nil)
    }
}
