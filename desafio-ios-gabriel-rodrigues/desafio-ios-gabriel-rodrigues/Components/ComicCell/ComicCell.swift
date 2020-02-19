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
    var id: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicImage.layer.cornerRadius = 4
        comicImage.layer.masksToBounds = true
    }

    func configure(with info: CharacterInfo) {
        id = info.id
        comicImage.hero.id = info.name
//        characterNameLabel.text = info.name
        guard let pictureURL = info.pictureUrl, let url = URL(string: pictureURL) else {
            return
        }
//        characterImageView!.sd_setImage(with: url)
    }
}
