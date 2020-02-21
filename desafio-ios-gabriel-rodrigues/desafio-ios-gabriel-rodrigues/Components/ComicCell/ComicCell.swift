//
//  ComicCell.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit
import AlamofireImage

class ComicCell: UICollectionViewCell {

    @IBOutlet weak var comicImage: UIImageView!
    var id: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        comicImage.layer.cornerRadius = 4
        comicImage.layer.masksToBounds = true
    }

    func configure(with info: Comic) {
        id = info.id
        comicImage.hero.id = "\(info.id)"
        comicImage.af_setImage(withURL: URL(string: info.pictureUrl!)!)
    }
}
