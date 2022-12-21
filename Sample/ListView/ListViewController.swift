//
//  ListViewController.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import UIKit

class ListViewController: UIViewController {
    @IBOutlet weak var tableView:UITableView!
    var results:[Results] = []
    
    var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.callItunesAPI { result in
            switch result {
            case .success(let data):
                if let results = data.results {
                    self.results = results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                break
            case .failure(let error):
                print(error)
                break
            }
        }
        // Do any additional setup after loading the view.
    }

}


extension ListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackTableViewCell.self), for: indexPath)
        return cell
    }
    
    
    
}

extension ListViewController:UITableViewDelegate{
    
}
