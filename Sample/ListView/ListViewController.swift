//
//  ListViewController.swift
//  Sample
//
//  Created by Jagadeesha on 20/12/22.
//

import UIKit

class ListViewController: BaseViewController {
    @IBOutlet weak private var tableView: UITableView!
    var results: [Results] = []
    var viewModel = ListViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "iTunes Tracks"
        viewModel.callItunesAPI { result in
            switch result {
            case .success(let data):
                if let results = data.results {
                    self.results = results
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
            case .failure(_):
                self.alert(title: "Failure", message: "Something happened. Please try again later")
            }
        }
        // Do any additional setup after loading the view.
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if  let detailView = segue.destination as? DetailViewController {
                if let value = sender as? Results {
                    detailView.detailResult = value
                }
            }
        }
    }
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TrackTableViewCell.self), for: indexPath) as? TrackTableViewCell {
            cell.bind(data: results[indexPath.row])
            return cell
        } else {
           return UITableViewCell()
        }
    }
}

extension ListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "detail", sender: results[indexPath.row])
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        44
    }
}
