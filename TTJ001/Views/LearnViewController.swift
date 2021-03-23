//
//  LearnViewController.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/18/21.
//

import Foundation
import UIKit
import MapKit
import SwiftUI
import CoreData


class LearnViewController: UIViewController {
    
    //let vc = LearnViewController()
    var town:String = ""
    var county: String = ""
    var date: String = ""
    var info: String = ""
    var photo1: String = ""
    
    
    
    @IBOutlet weak var labelTown: UILabel!
    @IBOutlet weak var labelCounty: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var photoJail: UIImageView!
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        labelTown.text = town
        labelCounty.text = county
        labelDate.text = date
        labelInfo.text = info
        
        let displayPhoto: String = photo1 + ".jpg"
        
        
        
        print(displayPhoto)
    }

    
}

