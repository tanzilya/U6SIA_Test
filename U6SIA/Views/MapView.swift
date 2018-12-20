//
//  MapView.swift
//  U6SIA
//
//  Created by Tanzilya Yakshimbetova on 12/19/18.
//  Copyright © 2018 Tanzilya Yakshimbetova. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {

    var mapView = MKMapView()
    var lblAddress: UILabel = UILabel()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupUI()
    }
    
    public func height() -> (Float) {
        return 400.0
    }

    private func setupUI() {
        mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        lblAddress = UILabel()
        lblAddress.translatesAutoresizingMaskIntoConstraints = false
        lblAddress.textColor = .gray
        lblAddress.textAlignment = .left
        lblAddress.numberOfLines = 2
        
        self.addSubview(mapView)
        self.addSubview(lblAddress)
        
        let c1 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[mapView]-10-|",
                                                        options: [],
                                                        metrics: [:],
                                                        views: ["mapView":mapView])
        let c2 = NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[lblAddress]-10-|",
                                                options: [],
                                                metrics: [:],
                                                views: ["lblAddress":lblAddress])
        let c3 = NSLayoutConstraint.constraints(withVisualFormat: "V:|-15-[mapView]-10-[lblAddress(50)]-10-|",
                                                options: [],
                                                metrics: [:],
                                                views: ["mapView":mapView,
                                                        "lblAddress":lblAddress])
        
        self.addConstraints(c1)
        self.addConstraints(c2)
        self.addConstraints(c3)
    }
    
    
}
