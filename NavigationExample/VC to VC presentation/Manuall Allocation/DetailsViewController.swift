//
//  ViewController.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    init(detailsText: String, didFinish: @escaping () -> Void) {
        self.detailsText = detailsText
        self.didFinish = didFinish
        super.init(nibName: nil, bundle: nil)
    }
    private let detailsText: String
    private let didFinish: () -> Void

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addLabel()
        addCloseButton()
    }

    private func addLabel() {
        label.text = detailsText
        view.addSubview(label)
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func addCloseButton() {
        view.addSubview(closeButton)
        closeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        closeButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -44).isActive = true
    }

    @objc
    private func didTapClose() {
        didFinish()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let label: UILabel = {
        let label = UILabel();
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let closeButton: UIButton = {
        let button =  UIButton(type: .system);
        button.setTitle("Close", for: .normal)
        button.addTarget(self, action: #selector(didTapClose), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

