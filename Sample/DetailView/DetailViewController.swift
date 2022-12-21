//
//  DetailViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import UIKit

class DetailViewController: BaseViewController {
    @IBOutlet weak private var detailLabel: UILabel!
    var detailResult: Results?

    override func viewDidLoad() {
        super.viewDidLoad()
        if let result = detailResult {
            detailLabel.text =
            """
            TrackName : \(result.trackName ?? "")
            ArtistName : \(result.artistName ?? "")
            """
        }
        // Do any additional setup after loading the view.
    }

}
