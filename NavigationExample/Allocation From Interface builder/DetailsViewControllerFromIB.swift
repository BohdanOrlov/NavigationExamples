//
//  DetailsViewControllerFromXib.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class DetailsViewControllerFromIB: UIViewController {

    public var detailsText: String?
    public var didFinish: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = detailsText
    }
    
    @IBAction private func didTapClose() {
        didFinish?()
    }
    @IBOutlet private var label: UILabel!
}
