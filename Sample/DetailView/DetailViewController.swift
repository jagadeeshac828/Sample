//
//  DetailViewController.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var detailLabel:UILabel!
    var detailResult:Results?

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
