//
//  CharactersViewController.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit

class CharactersViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var charactersCollectionView: UICollectionView!
    
    let charactersViewModel = CharactersViewModel()
    var cellIdentifier = "CharactersCell"
    var charactersInfo = [CharacterInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        charactersViewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        charactersViewModel.fetchCharacters(name: "")
    }
    
    func setupView() {
        self.charactersCollectionView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
    }
}

extension CharactersViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return charactersInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CharactersCell  else {
            return UICollectionViewCell()
        }
        cell.configure(with: charactersInfo[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let characterVC = UIStoryboard(name: "SingleCharacter", bundle: nil).instantiateInitialViewController() as? SingleCharacterViewController else {
            return
        }
        characterVC.modalPresentationStyle = .fullScreen
        self.present(characterVC, animated: true, completion: nil)
    }
}

extension CharactersViewController: UISearchBarDelegate {
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            charactersViewModel.fetchCharacters(name: text)
        }
    }
}

extension CharactersViewController: CharactersViewProtocol {
    func updateView(with charactersInfo: [CharacterInfo]) {
        self.charactersInfo = charactersInfo
        DispatchQueue.main.async {
            self.charactersCollectionView.reloadData()
        }
    }
    
    func show(error: String) {
        self.presentMessage(with: "Ops", body: error, option: "Tente novamente")
    }
}
