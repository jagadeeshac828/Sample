//
//  SDWebImageService.swift
//  Sample
//
//  Created by Jagadeesha on 22/12/22.
//

import Foundation
import SDWebImage

extension UIImageView {
    func loadImageURL(_ url: URL) {
        self.sd_setImage(with: url)
    }
}
