//
//  MapViewController.swift
//  Navigation
//
//  Created by Vladislav Green on 2/20/23.
//

import UIKit
import MapKit


class MapViewController: UIViewController, MKMapViewDelegate  {
    
    var sourceLocation: CLLocationCoordinate2D?
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView()
        
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        mapView.mapType = .standard
        mapView.showsCompass = true
        mapView.showsScale = true
        
        mapView.showsUserLocation = true
        
        let pointsOfInterestFilter = MKPointOfInterestFilter()
        mapView.pointOfInterestFilter = pointsOfInterestFilter
        
        return mapView
    }()
    
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(setUserLocationPoint),
            name: NSNotification.Name(rawValue: "sharedLocation"),
            object: nil)
                
        setupViews()
        
        findUserLocation()
        
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
        mapView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        LocationManager.shared.manager.requestLocation()
    }
    
    
    // MARK: - Private
    
    private func setupNavigationBar() {
        title = "Найди кота"
        
        let rightButton = UIButton(type: .custom)
            rightButton.setImage(UIImage(systemName: "delete.left"), for: .normal)
            rightButton.addTarget(self, action: #selector(removeNewPins), for: .touchUpInside)
        let rightItem = UIBarButtonItem(customView: rightButton)
        navigationItem.rightBarButtonItem = rightItem
    }
    
    private func setupViews() {
        
        view.backgroundColor = .systemBackground
        
        view.addSubview(mapView)
        
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            mapView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }
    
    private func findUserLocation() {
        LocationManager.shared.manager.requestAlwaysAuthorization()
        LocationManager.shared.setupLocationManager()
        
    }
    
    @objc
    private func setUserLocationPoint(notif: NSNotification) {
        
        let object = notif.object as! Dictionary<String, AnyObject>
//        let error = object["error"]
        let location = object["location"] as! CLLocation
        let lat = location.coordinate.latitude
        let lon = location.coordinate.longitude
        
        let initialLocation = CLLocationCoordinate2D(
            latitude: lat,
            longitude: lon
        )
        self.mapView.setCenter(
            initialLocation,
            animated: false
        )
        
        let region = MKCoordinateRegion(
            center: initialLocation,
            latitudinalMeters: 200000,
            longitudinalMeters: 200000
        )
        self.mapView.setRegion(
            region,
            animated: false
        )
        
        self.mapView.register(
            MapAnnotationView.self, forAnnotationViewWithReuseIdentifier: MKMapViewDefaultAnnotationViewReuseIdentifier
        )
        
        let annotation = setInitialPin(name: "Кот", lat: lat, lon: lon)
        self.mapView.addAnnotations([annotation])
    }
    
    
    private func setInitialPin(name: String, lat: Double, lon: Double) -> MKAnnotation {
        
        let point = MapAnnotation(
            title: name,
            coordinate: CLLocationCoordinate2D(
                                        latitude: lat,
                                        longitude: lon),
            info: "Проложите маршрут отсюда!")
        
        self.mapView.addAnnotations([point])
        sourceLocation = point.coordinate
        return point
    }
    
    
    
    // Тапнуть по карте и получить координаты
    @objc
    private func longTap(sender: UITapGestureRecognizer) {
        
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
            requestDirection(destinationLocation: locationOnMap)
        }
    }
    
    private func addAnnotation(location: CLLocationCoordinate2D){
        let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Новый Пин"
        self.mapView.addAnnotation(annotation)
    }
    

    
    //  Проложить маршрут
    //  https://www.hackingwithswift.com/example-code/location/how-to-find-directions-using-mkmapview-and-mkdirectionsrequest
    
    func requestDirection(destinationLocation: CLLocationCoordinate2D) {
        
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: sourceLocation!, addressDictionary: nil))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationLocation, addressDictionary: nil))
        request.requestsAlternateRoutes = true
        request.transportType = .automobile
        
        let directions = MKDirections(request: request)
        
        directions.calculate { [unowned self] response, error in
            guard let unwrappedResponse = response else { return }
            
            for route in unwrappedResponse.routes {
                self.mapView.addOverlay(route.polyline)
                self.mapView.setVisibleMapRect(route.polyline.boundingMapRect, animated: true)
            }
        }
    }

    
    // Показать проложенный маршрут
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let renderer = MKPolylineRenderer(polyline: overlay as! MKPolyline)
        renderer.strokeColor = UIColor.blue
        return renderer
    }
    
    
    // Удалить новые Пины
    @objc
    private func removeNewPins() {
        
        for annotation in mapView.annotations{
            guard annotation.title == "Новый Пин"  else { return }
            self.mapView.removeAnnotation(annotation)
        }
    }
    
}

