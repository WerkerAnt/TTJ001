
import Foundation
import UIKit
import MapKit
import SwiftUI
import CoreData


class SplashViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Prints location of SQL Database on Developer Machine
        
        print("SQL Database located in: ")
        let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { // Change `2.0` to the desired number of seconds.
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.present(newViewController, animated: true, completion: nil)
        }
        
        
    }
    
//    func isFirstLaunch() -> Bool {
//        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
//        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
//        if (isFirstLaunch) {
//            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
//            UserDefaults.standard.synchronize()
//        }
//        return isFirstLaunch
//    }
    

    
}
