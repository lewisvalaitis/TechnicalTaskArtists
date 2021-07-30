//
//  Wireframe.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 30/07/2021.
//

import Foundation
import UIKit

// MARK: Wireframe Protocol
protocol WireframeProtocol {
    func presentArtistDetail(viewModel: ArtistDetailViewModel)
}

// MARK: - Wireframe
struct Wireframe: WireframeProtocol {
    
    var navigationController: UINavigationController
    
    func presentArtistDetail(viewModel: ArtistDetailViewModel) {
        
    }
}
