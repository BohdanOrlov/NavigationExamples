//
//  PresenterProtocol.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

protocol ViewControllerPresenting {
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)?)
    func dismiss(animated flag: Bool, completion: (() -> Swift.Void)?)
}

extension UIViewController: ViewControllerPresenting {
}
