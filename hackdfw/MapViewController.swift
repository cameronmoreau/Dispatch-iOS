//
//  ViewController.swift
//  Dispatch
//
//  Created by Cameron Moreau on 4/16/16.
//  Copyright © 2016 Mobi. All rights reserved.
//

import UIKit
import MapKit
import SCLAlertView
import PusherSwift

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
    let locationManager = CLLocationManager()
    let api = ApiManager()
    
    let pusher = Pusher(key: "7c698f5c95d6b5063a7c")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let channel = pusher.subscribe("dispatch")
        channel.bind("location", callback: { (data: AnyObject?) -> Void in
            self.requestRecieved()
            print("message received: \(data)")
        })
        
        pusher.connect()

        
        //Icon at nav
        let logo = UIImage(named: "logo_dispatch")
        let imageView = UIImageView(image: logo)
        imageView.contentMode = .ScaleAspectFit;
        imageView.frame = CGRectMake(0, 0, imageView.frame.width, 35)
        self.navigationItem.titleView = imageView
        
        //Location stuff
        if CLLocationManager.locationServicesEnabled() {
            setupLocation()
        } else {
            print("Location not enabled")
            locationManager.requestAlwaysAuthorization()
        }
        
        //data
        api.getVehicles { vehicles in
            if let vehicles = vehicles {
                for v in vehicles {
                    if let location = v.location {
                        let pin = CustomAnnotation()
                        pin.title = v.name
                        pin.coordinate = location
                        
                        switch(v.type!) {
                        case UserType.Fire.rawValue:
                            pin.imageName = "ic_fire_truck"
                            break
                        case UserType.Medic.rawValue:
                            pin.imageName = "ic_ambulance"
                            break
                        default:
                            pin.imageName = "ic_police"
                            break
                        }
                        
                        self.map.addAnnotation(pin)
                    }
                }
                
                print("pins dropped")
            }
        }
        
        //requestRecieved()
        
        self.map.delegate = self
    }
    
    func requestRecieved() {
        let alert = SCLAlertView()
        alert.addButton("Accept") {
            print("accest")
        }
        
        alert.showTitle(
            "Emergency Incident",
            subTitle: "New incident reported near you",
            duration: 15.0,
            completeText: "Decline",
            style: .Wait,
            colorStyle: 0x43d4e6,
            colorTextButton: 0xFFFFFF
        )
    }
    
    // Mark: - Helper functions
    
    func zoomMapToBounds(start: CLLocationCoordinate2D, end: CLLocationCoordinate2D) {
        let topLeftLat = max(start.latitude, end.latitude)
        let topLeftLng = min(start.longitude, end.longitude)
        
        let bottomRightLat = min(start.latitude, end.latitude)
        let bottomRightLng = max(start.longitude, end.longitude)
        
        let centerLat = topLeftLat - (topLeftLat - bottomRightLat) * 0.5
        let centerLng = topLeftLng + (bottomRightLng - topLeftLng) * 0.5
        
        let spanLat = abs(topLeftLat - bottomRightLat) * 1.8
        let spanLng = abs(bottomRightLng - topLeftLng) * 1.8
        
        let center = CLLocationCoordinate2DMake(centerLat, centerLng)
        let span = MKCoordinateSpanMake(spanLat, spanLng)
        
        var region = MKCoordinateRegionMake(center, span)
        region = self.map.regionThatFits(region)
        self.map.setRegion(region, animated: true)
        
        //Location stuff
        if CLLocationManager.locationServicesEnabled() {
            setupLocation()
        } else {
            print("Location not enabled")
            locationManager.requestAlwaysAuthorization()
        }
        
        self.map.delegate = self
    }
    
    func setupLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    // MARK: - Location Delegate
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            let zoom = 0.1
            
            let region = MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: zoom, longitudeDelta: zoom))
            self.map.setRegion(region, animated: true)
            
            
            locationManager.stopUpdatingLocation()
        }
    }
    
    // MARK: - Map Delegate
    func mapView(mapView: MKMapView, viewForAnnotation annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is CustomAnnotation {
            let pinView = MKAnnotationView(annotation: annotation, reuseIdentifier: "")
            
            let pin = annotation as! CustomAnnotation
            pinView.image = UIImage(named:pin.imageName)
            return pinView
        }
        
        return nil
    }
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let view = MKPolylineRenderer(overlay: overlay)
            return view
        }
        
        return MKPolylineRenderer()
    }
}

