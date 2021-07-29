//
//  APIClient.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import Foundation
import RxSwift

protocol APIClientProtocol {
    func fetchArtists() -> Observable<[Artist]>
}
