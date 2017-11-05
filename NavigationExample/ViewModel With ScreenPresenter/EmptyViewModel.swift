//
//  EmptyViewModel.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import Foundation

class EmptyViewModel: ActionHandling {
    let screenPresenter: ScreenPresenting
    init(screenPresenter: ScreenPresenting) {
        self.screenPresenter = screenPresenter
    }
    func handleAction(for detailText: String) {
        screenPresenter.presentScreen(for: detailText, didFinish: { [weak self] in
            self?.screenPresenter.dismissScreen()
        })
    }
}
