//
//  SceneDelegate.swift
//  TechnicalTaskArtists
//
//  Created by Lewis Valaitis on 29/07/2021.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene),
              let navController = scene.windows.first?.rootViewController as? UINavigationController,
              let artistsVC = navController.viewControllers.first as? ArtistsViewController else { fatalError("Scene delegate.") }
        
        struct MockAPIClient: APIClientProtocol {
            func fetchArtists() -> Observable<[Artist]> {
                return .just([Artist(name: "Louis Capaldi"), Artist(name: "Maneskins"), Artist(name: "Ed Sheeran")])
            }
        }
        
        let viewModel = ArtistsViewModel(apiClient: MockAPIClient())
        artistsVC.viewModel = viewModel
        
    }



}

