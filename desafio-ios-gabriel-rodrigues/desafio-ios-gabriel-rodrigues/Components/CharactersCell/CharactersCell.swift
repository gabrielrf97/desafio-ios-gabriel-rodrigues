//
//  CharactersCell.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class CharactersCell: UICollectionViewCell {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterNameLabel: UILabel!
    var id: Int!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        characterImageView.layer.cornerRadius = 20
        characterImageView.layer.masksToBounds = true
    }

    func configure(with info: CharacterInfo) {
        id = info.id
        characterNameLabel.text = info.name
    }
}