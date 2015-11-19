//
//  MapViewController.swift
//  T4IT
//
//  Created by Lubos Ilcik on 14/11/15.
//  Copyright © 2015 Touch4IT. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let t4ITLocation = CLLocationCoordinate2D(latitude: 48.1735998, longitude: 17.1654444)
        let region = MKCoordinateRegion(center: t4ITLocation, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
        
        let annotation = MKPointAnnotation()
        annotation.title = "Touch4IT s.r.o."
        annotation.coordinate = t4ITLocation
        
        mapView.addAnnotation(annotation)
    }


}
