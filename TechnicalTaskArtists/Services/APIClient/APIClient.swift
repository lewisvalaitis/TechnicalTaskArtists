//
//  APIClient.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import Foundation
import RxSwift


protocol APIClientProtocol {
    func fetchArtists(withName: String) -> Observable<[Artist]>
}

// MARK: - APIClient
enum APIClientError: Error {
    case url
    case data(Error)
}

struct APIClient: APIClientProtocol {
    private let baseURL = "http://musicbrainz.org/ws/2/artist/"
    private let urlSession = URLSession(configuration: .default)
    
    private func getArtistURL(withName name: String) -> Result<URL, APIClientError> {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return .failure(.url)
        }
        urlComponents.queryItems = [URLQueryItem(name: "query", value: name),
                                    URLQueryItem(name: "fmt", value: "json")]
        guard let url = urlComponents.url else {
            return .failure(.url)
        }
        return .success(url)
    }
    
    private func fetchData(from url: URL) -> Observable<Data> {
        return Observable.create { observable in
            let dataTask = self.urlSession.dataTask(with: url) { data, _, error in
                guard let data = data else {
                    observable.onError(error!)
                    return
                }
                observable.onNext(data)
            }
            dataTask.resume()
            return Disposables.create()
        }
    }
   
    func fetchArtists(withName name: String) -> Observable<[Artist]> {
        switch getArtistURL(withName: name) {
        case .success(let url):
            return fetchData(from: url)
                .flatMapLatest { data -> Observable<[Artist]> in
                    let decoder = JSONDecoder()
                    do {
                        let response = try decoder.decode(Response.self, from: data)
                        return .just(response.artists ?? [])
                    } catch {
                        return .error(APIClientError.data(error))
                    }
                }
        case .failure(let error):
            return .error(error)
        }
    }
}
