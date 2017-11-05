//
//  PresentationOptionsViewController.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class NavigationsExamplesViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == self.manualAllocationCell {
            self.presentViewControllerManually()
        } else if cell == self.allocationFromXibCell {
            self.presentViewControllerFromXib()
        } else if cell == self.allocationFromStoryboardCell {
            self.presentViewControllerFromStoryboard()
        } else if cell == self.segueCell {
            self.performSegue(withIdentifier: "detailsSegue", sender: nil)
        }
    }

    private func presentViewControllerManually() {
        let viewController = DetailsViewController(detailsText: "My details") { [weak self] in
            self?.dismiss(animated: true)
        }
        self.present(viewController, animated: true)
    }

    private func presentViewControllerFromXib() {
        let viewController = DetailsViewControllerFromIB(nibName: "DetailsViewControllerFromXib", bundle: nil)
        viewController.detailsText = "My details"
        viewController.didFinish = { [weak self] in
            self?.dismiss(animated: true)
        }
        self.present(viewController, animated: true)
    }

    private func presentViewControllerFromStoryboard() {
        let viewController = UIStoryboard(name: "DetailsViewControllerFromIB", bundle: nil).instantiateInitialViewController() as! DetailsViewControllerFromIB
        viewController.detailsText = "My details"
        viewController.didFinish = { [weak self] in
            self?.dismiss(animated: true)
        }
        self.present(viewController, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "detailsSegue" else { return }
        let viewController = segue.destination as! DetailsViewControllerFromIB
        viewController.detailsText = "My details"
        viewController.didFinish = { [weak viewController] in
            viewController?.performSegue(withIdentifier: "unwind", sender: nil)
        }
    }

    @IBAction private func unwind(sender: UIStoryboardSegue) {

    }

    @IBOutlet private var manualAllocationCell: UITableViewCell!
    @IBOutlet private var allocationFromXibCell: UITableViewCell!
    @IBOutlet private var allocationFromStoryboardCell: UITableViewCell!
    @IBOutlet private var segueCell: UITableViewCell!
}
