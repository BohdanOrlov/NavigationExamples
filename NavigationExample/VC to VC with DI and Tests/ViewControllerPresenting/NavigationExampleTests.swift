//
//  NavigationExampleTests.swift
//  NavigationExampleTests
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import XCTest
@testable import NavigationExample

class ViewControllerPresentingTest: XCTestCase {
    
    func testWhenCellTapped_ThenDetailsPresented() {
        // Given
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let examplesViewController = storyboard.instantiateViewController(withIdentifier: "NavigationsExamplesViewController") as! NavigationsExamplesViewController

        examplesViewController.nextViewControllerProvider = { detailsText, didFinish in
            return DetailsViewControllerToInject(detailsText: detailsText, didFinish: didFinish)

        }
        let mockPresenter = MockViewControllerPresenter()
        examplesViewController.presenterProvider = {
            return mockPresenter
        }
        // When
        examplesViewController.tableView(examplesViewController.tableView, didSelectRowAt: IndexPath(row: 1, section: 1))
        // Then
        let vc = mockPresenter.invokedPresentArguments.0
        XCTAssertTrue(vc is DetailsViewControllerToInject)
    }
    
}

class MockViewControllerPresenter: ViewControllerPresenting {
    public var invokedPresentArguments: (UIViewController, Bool, (() -> Void)?)!
    public var invokedDismissArguments: (Bool, (() -> Void)?)!
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        self.invokedPresentArguments = (viewControllerToPresent, flag, completion)
        completion?()
    }

    func dismiss(animated flag: Bool, completion: (() -> Void)?) {
        self.invokedDismissArguments = (flag, completion)
        completion?()
    }
}
