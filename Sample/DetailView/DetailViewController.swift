//
//  DetailViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import UIKit

final class DetailViewController: BaseViewController {
    @IBOutlet weak private var detailLabel: UILabel!
    @IBOutlet weak private var trackImageView: UIImageView!
    var detailResult: Results?
    var viewModel: DetailViewModelProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = detailResult?.trackName ?? ""
        assignValuesToUI()
    }
    
    private func assignValuesToUI() {
        if let result = detailResult {
            detailLabel.text = viewModel?.constructDataForLabel(result)
            if let url = URL(string: result.artworkUrl100 ?? "") {
                trackImageView.loadImageURL(url)
            }
        }
    }

}
