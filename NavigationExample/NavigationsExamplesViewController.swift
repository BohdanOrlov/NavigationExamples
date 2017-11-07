//
//  PresentationOptionsViewController.swift
//  NavigationExample
//
//  Created by Bohdan Orlov on 05/11/2017.
//  Copyright © 2017 Bohdan Orlov. All rights reserved.
//

import UIKit

class NavigationsExamplesViewController: UITableViewController {
    public var nextViewControllerProvider: ((_ detailsText: String, _ didFinish: @escaping () -> Void) -> UIViewController)!
    public var presenterProvider: (() -> ViewControllerPresenting)!
    public var actionHandler: ActionHandling!
    public var viewModel: EmptyViewModel!

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
        } else if cell == self.injectedVCCell {
            self.presentInjectedViewController()
        } else if cell == self.injectedVCAndPresenterCell {
            self.presentInjectedViewControllerViaPresenter()
        } else if cell == self.actionHandlerCell {
            self.handleAction()
        } else if cell == self.viewModelAndScreenPresenterCell {
            self.handleActionByViewModel()
        } else if cell == self.presentWithNavigationBarCell {
            self.presentDetailsWithNavigationBar()
        } else if cell == self.dismissAllAndPresentTwoCell {
            // Allows to open another VC to check that dismiss works
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3, execute: {
                self.dismissAllAndPresentTwo()
            })
        }
    }

    private func presentViewControllerManually() {
        let viewController = DetailsViewController(detailsText: "My details") { [weak self] in
            self?.dismiss(animated: true)
        }
        self.present(viewController, animated: true)
    }

    private func presentInjectedViewController() {
        let viewController = self.nextViewControllerProvider("My details") { [weak self] in
            self?.dismiss(animated: true)
        }
        self.present(viewController, animated: true)
    }

    private func presentInjectedViewControllerViaPresenter() {
        let viewController = self.nextViewControllerProvider("My details") { [weak self] in
            self?.presenterProvider().dismiss(animated: true, completion: nil)
        }
        self.presenterProvider().present(viewController, animated: true, completion: nil)
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

    private func handleAction() {
        self.actionHandler.handleAction(for: "My details")
    }

    private func handleActionByViewModel() {
        self.viewModel.handleAction(for: "My details")
    }

    private func presentDetailsWithNavigationBar() {
        let viewController = self.nextViewControllerProvider("My details") { [weak self] in
            self?.dismissRespectingNavigationBar(animated: true, completion: nil)
        }
        self.presentWithNavigationBar(viewController, animated: true, completion: nil)
    }

    private func dismissAllAndPresentTwo() {
        let popAndPresent = { [weak self] in
            self?.navigationController?.popToRootViewController(animated: true)
            self?.presentTwoDetailsControllers()
        }
        if self.presentedViewController != nil {
            self.dismiss(animated: true) {
                popAndPresent()
            }
        } else {
            popAndPresent()
        }
    }

    private func presentTwoDetailsControllers() {
        let viewController = self.nextViewControllerProvider("My details") { [weak self] in
            self?.dismissRespectingNavigationBar(animated: true, completion: nil)
        }
        self.presentWithNavigationBar(viewController, animated: true, completion: {
            [weak self] in
            guard let sSelf = self else { return }
            let viewController2 = sSelf.nextViewControllerProvider("My another details") { [weak self] in
                self?.dismissRespectingNavigationBar(animated: true, completion: nil)
            }
            sSelf.presentWithNavigationBar(viewController2, animated: true, completion: nil)
        })
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
    @IBOutlet private var injectedVCCell: UITableViewCell!
    @IBOutlet private var injectedVCAndPresenterCell: UITableViewCell!
    @IBOutlet private var actionHandlerCell: UITableViewCell!
    @IBOutlet private var viewModelAndScreenPresenterCell: UITableViewCell!
    @IBOutlet private var presentWithNavigationBarCell: UITableViewCell!
    @IBOutlet private var dismissAllAndPresentTwoCell: UITableViewCell!
}
