//
//  ViewController.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import UIKit

// MARK: - Artists View Controller
class ArtistsViewController: UIViewController {
    // MARK: Outlets
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    // MARK: Properties
    var viewModel: ArtistsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

