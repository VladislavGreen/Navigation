//
//  SceneDelegate.swift
//  Navigation
//
//  Created by Vladislav Green on 8/22/22.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let viewController = LoginViewController()
        
        let loginFactory = MyLoginFactory()
        viewController.loginDelegate = loginFactory.makeLoginInspector()
        
        let loginViewController = UINavigationController (rootViewController: viewController)
        let feedViewController = UINavigationController (rootViewController: FeedViewController())
        let audioViewController = UINavigationController (rootViewController: AudioViewController())
        let videoViewController = UINavigationController (rootViewController: VideoViewController())
        let recordingAudioViewController = UINavigationController (rootViewController: RecordingAudioViewController())
        
        let tabBarController = TabBarController()
        tabBarController.viewControllers = [
            feedViewController, loginViewController, audioViewController, videoViewController, recordingAudioViewController
        ]
        
        let item1 = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        let item2 = UITabBarItem(title: "Profile", image:  UIImage(systemName: "person.fill"), tag: 1)
        let item3 = UITabBarItem(title: "Audio", image: UIImage(systemName: "speaker.fill"), tag: 2)
        let item4 = UITabBarItem(title: "Video", image: UIImage(systemName: "tv"), tag: 3)
        let item5 = UITabBarItem(title: "Recorder", image: UIImage(systemName: "mic.fill"), tag: 4)
        
        feedViewController.tabBarItem = item1
        loginViewController.tabBarItem = item2
        audioViewController.tabBarItem = item3
        videoViewController.tabBarItem = item4
        recordingAudioViewController.tabBarItem = item5
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = tabBarController // Your initial view controller.
        window.makeKeyAndVisible()
        self.window = window
        
        // К заданию 1.1 "Хранение данных" с Network Manager (выключено пока, что-бы не мешало)
//        if let appConfiguration = AppConfiguration.allCases.randomElement() {
//            NetworkManager.request(for: appConfiguration)
//        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
        do {
            try FirebaseAuth.Auth.auth().signOut()
            print("You have signed out")
        } catch {
            print("Sign out error")
        }
        
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

}

