//
//  PlanViewController.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/18/21.
//

import Foundation
import UIKit
import MapKit
import SwiftUI
import CoreData
import CoreLocation


class PlanViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    var town: String = ""
    var lat: Double = 0
    var long: Double = 0
    
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var sliderCurrentLocation: UISwitch!
    @IBOutlet weak var textDeparture: UITextField!
    @IBOutlet weak var labelDestination: UILabel!
    @IBOutlet weak var mapViewDirections: MKMapView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if sliderCurrentLocation.isOn == true {
            textDeparture.isEnabled = false
        }
        if sliderCurrentLocation.isOn == false {
            textDeparture.isEnabled = true
        }
        
        labelDestination.text = town
        textDeparture.text = "Home"
        
        
        //Update Current Location
        self.locationManager.requestAlwaysAuthorization()

            // For use in foreground
            self.locationManager.requestWhenInUseAuthorization()

            if CLLocationManager.locationServicesEnabled() {
                locationManager.delegate = self
                locationManager.desiredAccuracy = kCLLocationAccuracyBest
                locationManager.startUpdatingLocation()
            }

            mapViewDirections.delegate = self
            mapViewDirections.mapType = .standard
            mapViewDirections.isZoomEnabled = true
            mapViewDirections.isScrollEnabled = true

            if let coor = mapViewDirections.userLocation.location?.coordinate{
                mapViewDirections.setCenter(coor, animated: true)
            }
        
    }
    
    @IBAction func btnLaunchMap(_ sender: Any) {

        let latitude:CLLocationDegrees =  lat
        let longitude:CLLocationDegrees =  long

            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = "Jail"
        mapItem.openInMaps(launchOptions: options)

    }
    
    @IBAction func sldrCurrentLocation(_ sender: Any) {
        if sliderCurrentLocation.isOn == true {
            textDeparture.isEnabled = false
        }
        else if sliderCurrentLocation.isOn == false {
            textDeparture.isEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue:CLLocationCoordinate2D = manager.location!.coordinate

        mapViewDirections.mapType = MKMapType.standard

        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        mapViewDirections.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = locValue
        annotation.title = "Jail in Town"
        annotation.subtitle = "Current Location"
        mapViewDirections.addAnnotation(annotation)

        //centerMap(locValue)
    }
    
}
