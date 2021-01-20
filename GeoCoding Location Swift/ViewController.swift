//
//  ViewController.swift
//  GeoCoding Location Swift
//
//  Created by Bilal Durnagöl on 19.01.2021.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    private let map: MKMapView = {
        let map = MKMapView()
        return map
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "MAP"
        view.addSubview(map)
        LocationManager.shared.getUserLocation(completion: {[weak self] location in
            guard let strongSelf = self else {return}
            strongSelf.addPinMap(location: location)
        })
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        map.frame = view.bounds
    }
    
    private func addPinMap(location: CLLocation) {
        let pin = MKPointAnnotation()
        pin.coordinate = location.coordinate
        map.setRegion(MKCoordinateRegion(
            center: location.coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.07,
                                   longitudeDelta: 0.07
            )
        ),
        animated: true)
        map.addAnnotation(pin)
        
        LocationManager.shared.resolveLocationName(with: location, completion: {[weak self]locationName in
            self?.title = locationName
        })
    }
}
