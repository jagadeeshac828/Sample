//
//  ListViewController.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import UIKit

final class ListViewController: BaseViewController {
    @IBOutlet weak private var tableView: UITableView!
    var results: [Results] = []
    var viewModel: ListViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Constants.listViewTitle
        
        viewModel?.resultsDidChange = { [weak self] in
            DispatchQueue.main.async {
                if let results = self?.viewModel?.results {
                    self?.results = results
                }
                self?.removeSpinner()
                self?.tableView.reloadData()
            }
        }
        
        viewModel?.errorDidChange = { [weak self] in
            DispatchQueue.main.async {
                self?.removeSpinner()
                if let error = self?.viewModel?.errorMessage {
                    self?.alert(title: Constants.failureMessage, message: error)
                }
            }
        }
        
        showSpinner(UIActivityIndicatorView.Style.medium)
        viewModel?.listItunesTrack()
    }
    
}

extension ListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackTableViewCell.self), for: indexPath) as! TrackTableViewCell
        cell.bind(data: results[indexPath.row])
        return cell
    }
    
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let viewController: DetailViewController = DetailViewController.instantiate(.main)
        viewController.viewModel = DetailViewModel()
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
}
