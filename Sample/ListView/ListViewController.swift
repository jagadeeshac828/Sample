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
    
    // This method for navigate to detailView
    private func navigateToDetailView(_ data: Results) {
        let viewController: DetailViewController = DetailViewController.instantiate(.main)
        viewController.viewModel = DetailViewModel()
        viewController.detailResult = data
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
}

  // MARK: - UITableViewDataSource
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

// MARK: - UITableViewDelegate
extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        navigateToDetailView(results[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
    
}
