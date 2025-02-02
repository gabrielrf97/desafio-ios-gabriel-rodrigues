//
//  SingleCharacterViewController.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit
import Hero
import AlamofireImage

class SingleCharacterViewController: UIViewController {

    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var characterName: UILabel!
    @IBOutlet weak var characterDescription: UITextView!
    @IBOutlet weak var comicsLabel: UILabel!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    let comicIdentifier = "ComicCell"
    
    var character: Character! //Not a good pattern in MVVM, but creating a struct would be model duplication
    var comics : [Comic]?
    let viewModel = SingleCharacterViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        self.hero.isEnabled = true
        viewModel.delegate = self
        viewModel.fetch(character.comics!)
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        comicsCollectionView.register(UINib(nibName: comicIdentifier, bundle: nil), forCellWithReuseIdentifier: comicIdentifier)
        guard let _character = character else {
            return
        }
        characterImageView.hero.id = _character.name
        characterImageView!.af_setImage(withURL: URL(string: _character.pictureUrl!)!)
        characterName.text = _character.name
        characterDescription.text = _character.description
    }
}

extension SingleCharacterViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return comics?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: comicIdentifier, for: indexPath) as? ComicCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: comics![indexPath.row])
        cell.comicImage.hero.id = "\(indexPath.row)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let comicVC = UIStoryboard(name: "Comic", bundle: nil).instantiateInitialViewController() as? ComicViewController else {
            return
        }
        comicVC.hero.isEnabled = true
        comicVC.hero.modalAnimationType = .autoReverse(presenting: .zoom)
        comicVC.modalPresentationStyle = .fullScreen
        comicVC.heroId = "\(indexPath.row)"
        comicVC.comic = comics![indexPath.row]
        self.present(comicVC, animated: true, completion: nil)
    }
}

extension SingleCharacterViewController: SigleCharacterViewDelegate {
    func updateView() {
        self.comics = viewModel.comics
        self.comicsCollectionView.reloadData()
    }
    
    func show(error: String) {
        self.presentMessage(with: "Ops", body: error, option: "Cancelar")
    }
}
