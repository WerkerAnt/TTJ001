//
//  ViewController.swift
//  TTJ001
//  Did you get this? yes
//  Created by Rodney Hermes on 2/17/21.
//Test
//Pull Test


import UIKit
import MapKit  //enables Map API
import CoreLocation  //enables User Location


class ViewController: UIViewController {
    @IBOutlet weak var tfTown: UITextField!
    @IBOutlet weak var tfCounty: UITextField!
    @IBOutlet weak var tfMaterial: UITextField!
    @IBOutlet weak var tfLong: UITextField!
    @IBOutlet weak var tfLat: UITextField!
    @IBOutlet weak var tfInfo: UITextField!
    @IBOutlet weak var tfLocalDetail: UITextField!
    
    @IBOutlet weak var tfRemoveJail: UITextField!
    @IBOutlet weak var tfJid: UITextField!
    @IBOutlet weak var tfSqft: UITextField!
    @IBOutlet weak var tfPhoto3: UITextField!
    @IBOutlet weak var tfPhoto2: UITextField!
    @IBOutlet weak var tfPhoto1: UITextField!
    @IBOutlet weak var tfDate: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var annotation:MKPointAnnotation!
    


    @IBAction func btnLocate(_ sender: Any) {
        self.getLocation()
        print("Jail Loaded!")
    }
    
    
    @IBAction func btnSubmit(_ sender: Any) {
        let newJail = Jail(context: self.context)
        newJail.town = tfTown.text
        newJail.material = tfMaterial.text
        newJail.county = tfCounty.text
        newJail.info = tfInfo.text
        newJail.photo1 = tfPhoto1.text
        newJail.photo2 = tfPhoto2.text
        newJail.photo3 = tfPhoto3.text
        newJail.localDetail = tfLocalDetail.text
        
        //Sqft needs to be cast as an Integer (Int64)
        let sqft:Int64? = Int64(tfSqft.text!)
        newJail.sqft = sqft!
        
        //jID needs to be cast as an Integer
        let jId:Int64? = Int64(tfJid.text!)
        newJail.uniqueID = jId!
        
        //Date needs to be cast from string to a Date data type
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        let date = dateFormatter.date(from: tfDate.text!)
        newJail.date = date
        
        //Latitude and Longitude need to be cast as Doubles
        let lat:Double? = Double(tfLat.text!)
        let long:Double? = Double(tfLong.text!)
        newJail.lat = lat!
        newJail.long = long!
        
        tfTown.text = ""
        tfCounty.text = ""
        tfMaterial.text = ""
        tfLat.text = ""
        tfLong.text = ""
        tfInfo.text = ""
        tfDate.text = ""
        tfPhoto1.text = ""
        tfPhoto2.text = ""
        tfPhoto3.text = ""
        tfSqft.text = ""
        tfJid.text = ""
        tfLocalDetail.text = ""
        
        do {
            try self.context.save()
        }
        catch {
            
        }
        
        
    }
    
    
    @IBAction func btnPrint(_ sender: Any) {
        self.fetchJail()
        var ct = 0
        let jailCt = items?.count
        
        if jailCt == 0 {
            print("Core Data is empty.")
            print("\n")
        }
        else{
        
        while ct < jailCt! {
            let jailLoaded = self.items![ct]
            //print(jailLoaded.town!)
            print(jailLoaded.town!)
            print(jailLoaded.county!)
            print(jailLoaded.material!)
            print(jailLoaded.sqft)
            print(jailLoaded.lat)
            print(jailLoaded.long)
            print(jailLoaded.date)
            print(jailLoaded.localDetail)
            print(jailLoaded.photo1!)
            print(jailLoaded.photo2!)
            print(jailLoaded.photo3!)
            print(jailLoaded.info!)
            print(jailLoaded.uniqueID)
            print("DB Count#:  \(ct)")
            print("\n")
            ct+=1
        }
        }
        
    }
    
    @IBAction func btnTest(_ sender: Any) {
        
       print("tester button")
    }
    
    
    @IBAction func btnDelete(_ sender: Any) {
        
        self.deleteJail()
        tfRemoveJail.text = ""
        
    }
    
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items:[Jail]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*self.fetchJail()
        var ct = 0
        let jailCt = items?.count
        
        while ct < jailCt! {
            let jailLoaded = self.items![ct]
            //print(jailLoaded.town!)
            print(jailLoaded.county!)
            print(jailLoaded.material!)
            print("DB Item#:  \(ct)")
            print("\n")
            ct+=1
        }
        */
    
        //let jailLoaded = self.items![3]
        //nameLabel.text = jailLoaded.name
        
        
        // Do any additional setup after loading the view.
        
    
    }
    
    func fetchJail() {
        do{
            self.items = try context.fetch(Jail.fetchRequest())
            DispatchQueue.main.async {
                //after DB is reloaded
                
            }
        }
        catch{
            
        }
    }
    
    func deleteJail() {
        var stringJail = tfRemoveJail.text
        var removeJail = Int(stringJail!)!
        let jailToRemove = self.items![removeJail]
        self.context.delete(jailToRemove)
        
        do{
            try self.context.save()
        }
        catch {
            
        }
        self.fetchJail()
        
    }
    
    func getLocation() {
        self.fetchJail()
        let jailCt = (items?.count)!
        let jailLoaded = self.items![jailCt-1]
        //let location = CLLocation(latitude: jailLoaded.lat, longitude: jailLoaded.long)
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(jailLoaded.lat, jailLoaded.long)
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 50000, longitudinalMeters: 50000)
        mapView.region = region
        mapView.mapType = MKMapType.standard
        addAnnotation(coordinate, title: "The Jail", subtitle: "Texas" )
        
        
    }
    
    func addAnnotation(_ coordinate: CLLocationCoordinate2D, title: String, subtitle: String) {
        annotation = MKPointAnnotation()
        annotation.coordinate = coordinate
        annotation.title = title
        annotation.subtitle = subtitle
        mapView.addAnnotation(annotation)
        
    }


}

