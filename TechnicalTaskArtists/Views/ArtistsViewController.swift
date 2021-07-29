//
//  ViewController.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import UIKit
import RxSwift
import RxCocoa

// MARK: - Artists View Controller
class ArtistsViewController: UIViewController {
    
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    var viewModel: ArtistsViewModel!
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let searchText = searchBar.rx.text.asObservable()
        let input = ArtistsInput(searchText: searchText)
        let output = viewModel.transform(input: input)
        output.artists
            .drive(tableView.rx.items(cellIdentifier: String(describing: ArtistCell.self), cellType: ArtistCell.self)) { _, cellModel, cell in
                cell.configure(with: cellModel)
            }
            .disposed(by: disposeBag)
            
    }
}

// MARK: - Artist Cell
class ArtistCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    func configure(with cellModel: ArtistCellModel) {
        nameLabel.text = cellModel.nameText
    }
}
