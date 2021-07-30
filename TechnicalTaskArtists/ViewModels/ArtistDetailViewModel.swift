//
//  ArtistDetailViewModel.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 30/07/2021.
//

import Foundation

// MARK: - Input / Output
struct DetailInput {
    
}

protocol DetailOutputProtocol {
    
}

// MARK: - Artists View Model Protocol
protocol ArtistDetailViewModelProtocol {
    func transform(input: DetailInput) -> DetailOutputProtocol
}

// MARK: - Artists View Model
struct ArtistDetailViewModel: ArtistDetailViewModelProtocol {
    var apiClient: APIClientProtocol
}

extension ArtistDetailViewModel {
    struct Output: DetailOutputProtocol {
        
    }
   
    func transform(input: DetailInput) -> DetailOutputProtocol {
        return Output()
    }
}
