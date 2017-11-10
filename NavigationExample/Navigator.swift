//
//  Navigator.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 08/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

struct Screen {
    let name: String
    let parameters: [String: String]
}

protocol Navigating {
    func canPresent(screens: [Screen]) -> Bool
    func present(screens: [Screen])
}

public final class Navigator: Navigating {

    init(window: UIWindow) {
        self.window = window
    }

    func canPresent(screens: [Screen]) -> Bool {
        print(self.window.rootViewController?.presentedScreens())
        return true
    }

    func present(screens: [Screen]) {
        guard canPresent(screens: screens) else { assertionFailure(); return }
    }

    private let window: UIWindow
}

protocol ScreenDescribing {
    var screen: Screen { get }
}

extension UIViewController: ScreenDescribing {
    var screen: Screen {
        return Screen(name: String(describing: self), parameters: [:])
    }
    override open var description: String {
        return "\(self.screen.name)\n\(self.presentedScreens())"
    }
}

final class ViewControllerNode {
    let viewController: UIViewController
    var children = [ViewControllerNode]()
    init(_ viewController: UIViewController) {
        self.viewController = viewController
    }
}

protocol PresentedScreensProviding {
    func presentedScreens() -> [ViewControllerNode]
}

extension UIViewController: PresentedScreensProviding {
    func presentedScreens() -> [ViewControllerNode] {
        var result = [ViewControllerNode]()
        var node: ViewControllerNode?
        let isContainerController = self.isKind(of: UINavigationController.self)  // Consider adding other container controllers
        if isContainerController {
            if let navinationController = self as? UINavigationController {
                var lastNode: ViewControllerNode?
                for vc in navinationController.viewControllers {
                    let node = ViewControllerNode(vc)
                    if vc == navinationController.viewControllers.first {
                        result += [node]
                    }
                    lastNode?.children.append(node)
                    lastNode = node
                }
            }
        } else {
            node = ViewControllerNode(self)
        }

        if let viewController = self.presentedViewController {
            if let node = node {
                node.children = viewController.presentedScreens()
                result += [node]
            } else {
                result += viewController.presentedScreens()
            }
        }
        return result
    }
}
