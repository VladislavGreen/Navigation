//
//  MapAnnotation.swift
//  Navigation
//
//  Created by Vladislav Green on 2/20/23.
//

import MapKit


final class MapAnnotation: NSObject, MKAnnotation {
    
    var title: String?
    var coordinate: CLLocationCoordinate2D
    var info: String
    
    init(
        title: String,
        coordinate: CLLocationCoordinate2D,
        info: String
    ) {
        self.title = title
        self.coordinate = coordinate
        self.info = info
        
        super.init()
    }
}

