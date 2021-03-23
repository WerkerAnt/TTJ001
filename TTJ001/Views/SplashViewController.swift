
import Foundation
import UIKit
import MapKit
import SwiftUI
import CoreData


class SplashViewController: UIViewController {
    @IBOutlet weak var labelTest: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        labelTest.text = String(isFirstLaunch())
        
        //Prints location of SQL Database on Developer Machine
        
        print("SQL Database located in: ")
        let paths = FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        print(documentsDirectory)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
    
    func isFirstLaunch() -> Bool {
        let hasBeenLaunchedBeforeFlag = "hasBeenLaunchedBeforeFlag"
        let isFirstLaunch = !UserDefaults.standard.bool(forKey: hasBeenLaunchedBeforeFlag)
        if (isFirstLaunch) {
            UserDefaults.standard.set(true, forKey: hasBeenLaunchedBeforeFlag)
            UserDefaults.standard.synchronize()
        }
        return isFirstLaunch
    }
    

    
}
