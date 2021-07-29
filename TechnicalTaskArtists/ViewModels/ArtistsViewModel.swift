//
//  ArtistsViewModel.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import Foundation
import RxSwift
import RxCocoa

// MARK: - Input / Output
struct ArtistsInput {
    var searchText: Observable<String?>
}

protocol ArtistsOutputProtocol {
    var artists: Driver<[ArtistCellModel]> { get }
}

// MARK: - Artists View Model Protocol
protocol ArtistsViewModelProtocol {
    func transform(input: ArtistsInput) -> ArtistsOutputProtocol
}

// MARK: - Artists View Model
struct ArtistsViewModel: ArtistsViewModelProtocol {
    var apiClient: APIClientProtocol
}

extension ArtistsViewModel {
    struct Output: ArtistsOutputProtocol {
        var artists: Driver<[ArtistCellModel]>
    }
    
    func transform(input: ArtistsInput) -> ArtistsOutputProtocol {
        let artistCellModels = input.searchText
            .flatMapLatest { name -> Observable<[ArtistCellModel]> in
                print("****")
                return apiClient.fetchArtists(withName: name ?? "")
                    .catch { error -> Observable<[Artist]> in
                        switch error {
                        case APIClientError.data(let error): print("Data Error: \(error)")
                        case APIClientError.url: print("URL Error")
                        default: print(error)
                        }
                        return .just([])
                    }
                    .flatMapLatest { artists -> Observable<[ArtistCellModel]> in
                        let cellModels = artists.map { ArtistCellModel(nameText: $0.name) }
                        return .just(cellModels)
                    }
            }
            .asDriver(onErrorDriveWith: .empty())
        
        return Output(artists: artistCellModels)
    }
}
