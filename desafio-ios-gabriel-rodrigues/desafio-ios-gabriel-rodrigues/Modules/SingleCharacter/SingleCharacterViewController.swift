//
//  SingleCharacterViewController.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class SingleCharacterViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    let comicIdentifier = "ComicCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        comicsCollectionView.register(UINib(nibName: comicIdentifier, bundle: nil), forCellWithReuseIdentifier: comicIdentifier)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SingleCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comicIdentifier, for: indexPath) as? ComicCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comicVC = UIStoryboard(name: "Comic", bundle: nil).instantiateInitialViewController() as? ComicViewController else {
            return
        }
        comicVC.modalPresentationStyle = .fullScreen
        self.present(comicVC, animated: true, completion: nil)
    }
}
