//
//  AppDelegate.swift
//  Download Music MP3
//
//  Created by iMac on 02/02/22.
//

import UIKit
import IQKeyboardManagerSwift
import MKProgress
import LGSideMenuController

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sideMenuController: LGSideMenuController = LGSideMenuController()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldShowToolbarPlaceholder = true
        IQKeyboardManager.shared.enableAutoToolbar = true
        IQKeyboardManager.shared.keyboardDistanceFromTextField = 30
        
        // Handle Dark Mode
        handleDarkMode(.light)
        
        // Sidemenu
        createSideMenu()
        
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
         // GoogleAppOpenAds.shared.loadAds { }
    }
    
    // MARK: Methods
    func storyboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func sharedDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    // MARK: Loader
    func showLoader() {
        MKProgress.config.hudType = .activityIndicator
        MKProgress.config.hudColor = .white
        MKProgress.show()
    }
    
    func removeLoader() {
        MKProgress.hide()
    }
    
    // MARK: Handle Dark Mode
    func handleDarkMode(_ mode: UIUserInterfaceStyle) {
        if #available(iOS 13.0, *) {
            UIApplication.shared.windows.forEach { window in
                window.overrideUserInterfaceStyle = mode
            }
        }
    }
    
    // MARK: User tracking permission
    func requestIDFA(_ completion: @escaping (_ permissionGranted: Bool) -> Void) {
        completion(true)
    }
    
    // MARK: Side Menu
    func createSideMenu() {
        let rootviewcontroller = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        let navigation = UINavigationController.init(rootViewController: rootviewcontroller)
        navigation.navigationBar.isHidden = true
        
        let sideMenuVC = STORYBOARD.MAIN.instantiateViewController(withIdentifier: "SideMenuVC") as! SideMenuVC
        sideMenuController = LGSideMenuController(rootViewController: navigation, leftViewController: sideMenuVC, rightViewController: nil)
        sideMenuController.leftViewWidth = UIScreen.main.bounds.size.width - 100
        sideMenuController.leftViewPresentationStyle = .slideAbove
        sideMenuController.isLeftViewDisabled = false
        sideMenuController.isLeftViewSwipeGestureDisabled = true
        
        self.window?.rootViewController = sideMenuController
        self.window?.makeKeyAndVisible()
    }
    
}

extension UIApplication {
    class func topViewController(base: UIViewController? = (UIApplication.shared.delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(base: nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(base: selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(base: presented)
        }
        return base
    }
}
