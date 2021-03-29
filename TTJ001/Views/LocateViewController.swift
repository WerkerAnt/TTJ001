//
//  LocateViewController.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/14/21.
//

import Foundation
import UIKit
import MapKit
import SwiftUI
import CoreData


class LocateViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    let managedContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Jail")
    
    var annotation:MKPointAnnotation!
    @IBOutlet weak var labelCounty: UILabel!
    @IBOutlet weak var labelTown: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var sliderZoom: UISlider!
    @IBOutlet weak var labelLocalDetail: UILabel!
    @IBOutlet weak var pickerTown: UIPickerView!
    @IBOutlet weak var btnTest: UIButton!
    
    var pickerData = [["Caldwell","East Bernard","Fayetteville","Flatonia"]]
    var listJails = [NSManagedObject]()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pickerTown.setValue(UIColor.black, forKey: "textColor")
        self.pickerTown.delegate = self
        self.pickerTown.dataSource = self
        
        var results = try! managedContext.fetch(fetchRequest)
        
        //Alphabatizes the List of Towns in UIPickerView
        results.sort{($0 as AnyObject).town! < ($1 as AnyObject).town!}
        listJails = results as! [NSManagedObject]
        
    }
    
    @IBAction func sliderZoomMap(_ sender: Any) {
        
        
        
    }
    
    
       override func viewDidAppear(_ animated: Bool) {
       }
       
       //Number of Columns of Data - just 1 for towns
       func numberOfComponents(in pickerView: UIPickerView) -> Int {
           return pickerData.count
       }
       
    
       
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return listJails.count
       }
       
       //Data to return for row and component that is being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        //Pull Data for Selected town from CoreData
        let tempTown = listJails[row].value(forKey: "town") as! String
        let tempCounty = listJails[row].value(forKey: "county") as! String
        let tempLocalDetail = listJails[row].value(forKey: "localDetail") as! String
        let tempInfo = listJails[row].value(forKey: "info") as! String
        let tempPhoto1 = listJails[row].value(forKey: "photo1") as! String
        let tempSqft = listJails[row].value(forKey: "sqft") as! Int64
        let tempMaterial = listJails[row].value(forKey: "material") as! String
        let tempLat = listJails[row].value(forKey: "lat") as! Double
        let tempLong = listJails[row].value(forKey: "long") as! Double
        
        labelCounty.text = tempCounty
        labelLocalDetail.text = tempLocalDetail
        labelTown.text = tempTown
        
        
        //DATE to STRING FORMATTING
        let tempDate = listJails[row].value(forKey: "date") as! Date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        let tempDateString = dateFormatter.string(from: tempDate)
        
        
        
        
        
        getLocation(locationNum: row)
        
        
        //Send data to LearnViewController
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).town = tempTown
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).county = tempCounty
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).date = tempDateString
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).info = tempInfo
        
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).photo1 = tempPhoto1
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).sqft = tempSqft
        (self.tabBarController?.viewControllers?[2] as! LearnViewController).material = tempMaterial
        
        (self.tabBarController?.viewControllers?[1] as! PlanViewController).town = tempTown
        (self.tabBarController?.viewControllers?[1] as! PlanViewController).jailLat = tempLat
        (self.tabBarController?.viewControllers?[1] as! PlanViewController).jailLong = tempLong
        
        return tempTown
        
       }
       
    
       //Capture the pickerTown selection
       func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
           
       }
    
    func getLocation(locationNum: Int) {
        
        let jailLat = listJails[locationNum].value(forKey: "lat") as! Double
        let jailLong = listJails[locationNum].value(forKey: "long") as! Double
        let jailTown = listJails[locationNum].value(forKey: "town") as! String
        
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(jailLat, jailLong)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.region = region
        mapView.mapType = MKMapType.standard
        addAnnotation(coordinate, title: jailTown + " Jail", subtitle: "Texas" )
        
        
    }
    
    func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        
    }
        
    
       
}
    



    
    
    
 


