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
        
        
        let wireframe = Wireframe(navigationController: navController)
        let viewModel = ArtistsViewModel(apiClient: APIClient())
        artistsVC.viewModel = viewModel
        artistsVC.wireframe = wireframe
    }



}

