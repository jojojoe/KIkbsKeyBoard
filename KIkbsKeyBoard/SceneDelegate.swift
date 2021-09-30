//
//  SceneDelegate.swift
//  KIkbsKeyBoard
//
//  Created by JOJO on 2021/7/2.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainVC: KIkbsMainVC = KIkbsMainVC()

    func initMainVC() {
        let nav = UINavigationController.init(rootViewController: mainVC)
        nav.isNavigationBarHidden = true
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        #if DEBUG
        for fy in UIFont.familyNames {
            let fts = UIFont.fontNames(forFamilyName: fy)
            for ft in fts {
                debugPrint("***fontName = \(ft)")
            }
        }
        #endif
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
        
        
        initMainVC()
        
        //
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            [weak self] in
            guard let `self` = self else {return}
            debugPrint("KIKeykbsKeyBoard://")
            self.checkShowStoreVC(urlString: connectionOptions.urlContexts.first?.url.absoluteString ?? "")
            
        }
        
        
        
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
         
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
         
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
         
    }


    func checkShowStoreVC(urlString: String) {
        if urlString == "KIKeykbsKeyBoard://\("Store")" {
            
            if self.mainVC.visibleVC?.className.contains("KIkbsStoreVC") ?? false {
                
            } else {
                self.mainVC.present(KIkbsStoreVC(), animated: true, completion: nil)
            }
        }
    }
    
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.5) {
            [weak self] in
            guard let `self` = self else {return}
            
            self.checkShowStoreVC(urlString: URLContexts.first?.url.absoluteString ?? "")
            
            debugPrint("KIKeykbsKeyBoard://")
            
        }
    }
}

