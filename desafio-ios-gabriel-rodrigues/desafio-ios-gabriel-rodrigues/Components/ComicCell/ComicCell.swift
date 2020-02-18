//
//  ComicCell.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class ComicCell: UICollectionViewCell {

    @IBOutlet weak var comicImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicImage.layer.cornerRadius = 4
        comicImage.layer.masksToBounds = true
    }

}
