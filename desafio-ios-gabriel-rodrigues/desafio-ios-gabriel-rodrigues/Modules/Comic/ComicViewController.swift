//
//  ComicViewController.swift
//  desafio-ios-gabriel-rodrigues
//
//  Created by Gabriel on 18/02/20.
//  Copyright © 2020 Gabriel. All rights reserved.
//

import UIKit
import AlamofireImage

class ComicViewController: UIViewController {

    @IBOutlet weak var comicImageView: UIImageView!
    @IBOutlet weak var comicTitle: UILabel!
    @IBOutlet weak var comicDescription: UITextView!
    @IBOutlet weak var pricesLabel: UILabel!
    @IBOutlet weak var pricesTableView: UITableView!
    
    let cellIdentifier = "PriceCell"
    let viewModel = ComicViewModel()
    var heroId: String?
    var comic: Comic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        comicImageView.hero.id = heroId
    }
    
    @IBAction func backTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        self.pricesTableView.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.comicDescription.sizeToFit()
        comicImageView.af_setImage(withURL: URL(string: comic.pictureUrl!)!)
        comicTitle.text = comic.title
        comicDescription.text = comic.description ?? "No description"
    }
    
}

extension ComicViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comic.prices?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PriceCell else { return UITableViewCell()}
        cell.pricetype.text = comic.prices![indexPath.row].getType()
        cell.priceLabel.text = "\(comic.prices![indexPath.row].price)$"
        return cell
    }
}

extension ComicViewController: UpdateViewProtocol {
    func show(error: String) {
        self.presentMessage(with: "Ops", body: error, option: "Tente novamente")
    }
    
    func updateView(with comicInfo: Comic) {
        DispatchQueue.main.async {
//            let url = URL(string: comicInfo.pictureUrl ?? "")
            let url = URL(string: "")
            self.comicImageView.af_setImage(withURL: url!)
//            self.comicTitle.text = comicInfo.title
//            self.comicDescription.text = comicInfo.description
        }
    }
}
