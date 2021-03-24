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
    var jailLat: Double = 0
    var jailLong: Double = 0
    var currentLat: Double = 0
    var currentLong: Double = 0
    
    let locationManager = CLLocationManager()

    
    @IBOutlet weak var sliderCurrentLocation: UISwitch!
    @IBOutlet weak var textDeparture: UITextField!
    @IBOutlet weak var labelDestination: UILabel!
    @IBOutlet weak var mapViewDirections: MKMapView!
    
    override func viewDidLoad() {
        
        //Update Current Location
        mapViewDirections.removeOverlays(mapViewDirections.overlays)
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
        
        let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLat, longitude: currentLong), addressDictionary: nil))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: jailLat, longitude: jailLong), addressDictionary: nil))
                request.requestsAlternateRoutes = true
                request.transportType = .automobile

                let directions = MKDirections(request: request)

                directions.calculate { [unowned self] response, error in
                    guard let unwrappedResponse = response else { return }

                    for route in unwrappedResponse.routes {
                        self.mapViewDirections.addOverlay(route.polyline)
                        self.mapViewDirections.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    }
                }
        
        super.viewDidLoad()
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        mapViewDirections.removeOverlays(mapViewDirections.overlays)
        
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
        
        let request = MKDirections.Request()
                request.source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currentLat, longitude: currentLong), addressDictionary: nil))
                request.destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: jailLat, longitude: jailLong), addressDictionary: nil))
                request.requestsAlternateRoutes = true
                request.transportType = .automobile

                let directions = MKDirections(request: request)

                directions.calculate { [unowned self] response, error in
                    guard let unwrappedResponse = response else { return }

                    for route in unwrappedResponse.routes {
                        self.mapViewDirections.addOverlay(route.polyline)
                        self.mapViewDirections.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
                    }
                }
        
        
        
        //SLIDERS and Departure Text Field Properties below
        if sliderCurrentLocation.isOn == true {
            textDeparture.isEnabled = false
        }
        if sliderCurrentLocation.isOn == false {
            textDeparture.isEnabled = true
        }
        
        labelDestination.text = town
        textDeparture.text = "Current Location"
        
        
        
        
    }
    
    @IBAction func btnLaunchMap(_ sender: Any) {

        let latitude:CLLocationDegrees =  jailLat
        let longitude:CLLocationDegrees =  jailLong

            let regionDistance:CLLocationDistance = 10000
            let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
            let options = [
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
                MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
            ]
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            let mapItem = MKMapItem(placemark: placemark)
            mapItem.name = town + " Jail"
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

        let jailValue:CLLocationCoordinate2D = CLLocationCoordinate2DMake(jailLat, jailLong)

        currentLat = locValue.latitude
        currentLong = locValue.longitude
        
        mapViewDirections.mapType = MKMapType.standard
        
        let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        let region = MKCoordinateRegion(center: locValue, span: span)
        //mapViewDirections.setRegion(region, animated: true)

        let annotation1 = MKPointAnnotation()
        annotation1.coordinate = locValue
        annotation1.title = "Current Location"
        //annotation.subtitle = "No subtitle"
        mapViewDirections.addAnnotation(annotation1)
        
        let annotation2 = MKPointAnnotation()
        annotation2.coordinate = jailValue
        annotation2.title = town + " Jail"
        mapViewDirections.addAnnotation(annotation2)

        //centerMap(locValue)
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.systemBlue
            return renderer
        }
    
}
