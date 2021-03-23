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
    var sqft: Int64 = 0
    var material: String = ""
    
    
    
    @IBOutlet weak var labelTown: UILabel!
    @IBOutlet weak var labelCounty: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelInfo: UILabel!
    @IBOutlet weak var photoJail: UIImageView!
    @IBOutlet weak var labelSqft: UILabel!
    @IBOutlet weak var labelMaterial: UILabel!
    
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        labelTown.text = town
        labelCounty.text = county
        labelDate.text = date
        labelInfo.text = info
        let sqftString = String(sqft) + " sq. ft."
        labelSqft.text = sqftString
        labelMaterial.text = material
        
        let displayPhoto: String = photo1 + ".jpg"
        
        photoJail.image = UIImage(named: displayPhoto)
    }

    
}

