//
//  TrackTableViewCell.swift
//  Sample
//
//  Created by Jagadeesha on 21/12/22.
//

import UIKit

class TrackTableViewCell: UITableViewCell {
    @IBOutlet weak private var trackName: UILabel!
    @IBOutlet weak private var trackImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    // This method for add data to Cell
    func bind(data: Results) {
        trackName.text = "\(data.trackName ?? "null")"
        if let url = URL(string: data.artworkUrl100 ?? "") {
            trackImageView.loadImageURL(url)
        }
    }
    
}
