//
//  LocationViewController.swift
//  T4IT
//
//  Created by Lubos Ilcik on 14/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit
import MapKit

class LocationViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet private weak var mapView: MKMapView!
    
    private lazy var locationManager: CLLocationManager = {
        let lm = CLLocationManager()
        // configure lm...
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestWhenInUseAuthorization()
        //lm.distanceFilter = 100
        //lm.pausesLocationUpdatesAutomatically = true
        //lm.activityType = CLActivityTypeFitness
        return lm
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager.delegate = self
        print("starting location updates...")
        locationManager.startUpdatingLocation()

    }

    // MARK: - CLLocationManagerDelegate
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last
        // check if recent data
        if abs(Int32((lastLocation?.timestamp.timeIntervalSinceNow)!)) < 15 {
            // check if desired accuracy
            if lastLocation?.horizontalAccuracy <= 10 {
                print("stopping location updates")
                locationManager.stopUpdatingLocation()
            }
            print(lastLocation)
            setMap(lastLocation)
        }
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Error: \(error)")
        
        locationManager.stopUpdatingLocation()
    }
    
    // MARK: - dsiplaying user loaction on map
    
    private func setMap(location: CLLocation?) {
        guard let location = location else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(0.01, 0.01))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "User Location"
        annotation.coordinate = center
        mapView.addAnnotation(annotation)

    }
}
