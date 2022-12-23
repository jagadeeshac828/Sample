//
//  BaseViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
    }
    
    func navigateToDetailView(_ data: Results) {
        let viewController: DetailViewController = DetailViewController.instantiate(.main)
        viewController.viewModel = DetailViewModel()
        viewController.detailResult = data
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}
