//
//  MapViewController.swift
//  TestApp
//
//  Created by Ильнур Закиров on 19.02.2023.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let coordinates = [
        CLLocationCoordinate2D(latitude: 55.78662, longitude: 49.12616),
        CLLocationCoordinate2D(latitude: 55.78695, longitude: 49.12355),
        CLLocationCoordinate2D(latitude: 55.78664, longitude: 49.12244),
        CLLocationCoordinate2D(latitude: 55.78700, longitude: 49.12113),
        CLLocationCoordinate2D(latitude: 55.78787, longitude: 49.12255)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coordinates.forEach { coordinate in
            addAnotation(coordinate: coordinate)
        }
        setRegion()
    }
    
    //устанавливает пины
    func addAnotation(coordinate: CLLocationCoordinate2D) {
        let anotation = MKPointAnnotation()
        anotation.coordinate = coordinate
        mapView.addAnnotation(anotation)
    }
    
    //приближает карту
    func setRegion() {
        let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 55.78695, longitude: 49.12355),
                                        latitudinalMeters: 500,
                                        longitudinalMeters: 500)
        mapView.setRegion(region, animated: false)
    }
}
