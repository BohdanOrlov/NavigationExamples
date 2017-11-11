//
//  ScreenPresenting.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import Foundation

protocol ScreenPresenting {
    func presentScreen(for detailText: String, didFinish: @escaping () -> Void)
    func dismissScreen()
}
