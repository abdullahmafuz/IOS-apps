//
//  ViewController.swift
//  mapTagLocation
//
//  Created by Abdullah Mohammed on 26/02/2020.
//  Copyright © 2020 Abdullah Mohammed. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()

    
  
    @IBOutlet weak var mapTitle: UITextField!
    @IBOutlet weak var subTitle: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        mapView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(chooseLoaction(gestureRecognizer:)))
        gestureRecognizer.minimumPressDuration = 2
        mapView.addGestureRecognizer(gestureRecognizer)
        
        
    }
    
    @objc func hideKeyboard(){
        view.endEditing(true)
    }
    
    @objc func chooseLoaction(gestureRecognizer:UILongPressGestureRecognizer){
        
        if gestureRecognizer.state == .began{
            
            let touchpoint = gestureRecognizer.location(in: self.mapView)
            let touchCoordinates = self.mapView.convert(touchpoint, toCoordinateFrom: self.mapView)
            let annotaion = MKPointAnnotation()
            annotaion.coordinate = touchCoordinates
            annotaion.subtitle = subTitle.text
            annotaion.title = mapTitle.text
            self.mapView.addAnnotation(annotaion)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude)
        
        let span = MKCoordinateSpan(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
        
    }
    
    
    
    
    

}

