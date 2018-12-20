//
//  DetailViewController.swift
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

import UIKit;
import MapKit;

@objc class DetailViewController: UIViewController {
    
    var mapView: MapView?
    var btnDirections: ButtonView?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocationCoordinate2D = CLLocationCoordinate2D()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Map"
        self.view.backgroundColor = .white
        
        setupUI()
        loadData()
        setupLocationManager()
        
        btnDirections?.onClick = getDirections
    }
    
    func setupLocationManager() {
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
    }
    
    func getDirections() {
        if !CLLocationManager.locationServicesEnabled() {
            return
        }
        let directionsURL = "http://maps.apple.com/?saddr=\(self.currentLocation.latitude),\(self.currentLocation.longitude)&daddr=\(DataManager.shared().universityInfo.latitude),\(DataManager.shared().universityInfo.longitude)"
        guard let url = URL(string: directionsURL) else {
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    func setupUI() {
        mapView = MapView()
        mapView!.translatesAutoresizingMaskIntoConstraints = false
        
        btnDirections = ButtonView(title: "Directions")
        btnDirections?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mapView!)
        self.view.addSubview(btnDirections!)
        
        
        let c1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|[mapView]|",
                                                options: [],
                                                metrics: [:],
                                                views: ["mapView":mapView!])
        let c2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[btnDirections]-10-|",
                                                options: [],
                                                metrics: [:],
                                                views: ["btnDirections":btnDirections!])
        let c3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-30-[mapView(height)]-(>=10)-[btnDirections(60)]-10-|",
                                                options: [],
                                                metrics: ["height":mapView!.height()],
                                                views: ["mapView":mapView!,
                                                        "btnDirections":btnDirections!])
        
        self.view.addConstraints(c1)
        self.view.addConstraints(c2)
        self.view.addConstraints(c3)

    }
    
    func loadData() {
        ApiManager.shared().getUniversityInfo("\(DataManager.shared().selectedUniversity.title), \(DataManager.shared().selectedCity.title), \(DataManager.shared().selectedCountry.title)") { (success, info) in
            if (success) {
                DispatchQueue.main.async {
                    DataManager.shared().universityInfo = info!
                    self.mapView!.lblAddress.text = info!.formattedAddress
                    self.addAnnotation()
                }
            }
        }
    }
    
    func addAnnotation() {
        let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(DataManager.shared().universityInfo.latitude), longitude: CLLocationDegrees(DataManager.shared().universityInfo.longitude))
        let university = MKPointAnnotation()
        university.title = DataManager.shared().universityInfo.name
        university.coordinate = coordinate
        mapView?.mapView.addAnnotation(university)
        
        let regionRadius: CLLocationDistance = 1000
        let coordinateRegion = MKCoordinateRegion(center: coordinate,
                                                  latitudinalMeters: regionRadius * 2.0, longitudinalMeters: regionRadius * 2.0)
        mapView?.mapView.setRegion(coordinateRegion, animated: true)
    }
    

}


extension DetailViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
        self.currentLocation = locValue
    }
}
