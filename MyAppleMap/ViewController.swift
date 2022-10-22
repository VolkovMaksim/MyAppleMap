//
//  ViewController.swift
//  MyAppleMap
//
//  Created by Maksim Volkov on 20.10.2022.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    // координаты Санкт-Петербурга
    let coordinates = CLLocationCoordinate2D(latitude: 59.9342802, longitude: 30.3350986)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLocationManager()
        mapView.showsUserLocation = true
        mapView.showsCompass = true
    }
    
    private func configureLocationManager() {
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        locationManager.requestLocation()
    }
    
    private func addMarker() {
        // создаем аннотацию к задаваемой точке
        let annotations = MKPointAnnotation()
        // создаем заголовок аннотации
        annotations.title = "Санкт-Петербург"
        // создаем подзаголовок аннотации
        annotations.subtitle = "Какая-то точка"
        // задаем заголовок аннотации
        annotations.coordinate = coordinates
        mapView.addAnnotation(annotations)
        
    }
    
    @IBAction func addMarkDidTap(_ sender: UIButton) {
        addMarker()
    }
}

extension ViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let annotations = MKPointAnnotation()
        // создаем заголовок аннотации
//        annotations.title = "Я тут пробегал"
        // задаем заголовок аннотации
        annotations.coordinate = location.coordinate
        mapView.addAnnotation(annotations)
        
        let camera = MKMapCamera()
        camera.centerCoordinate.latitude = location.coordinate.latitude
        camera.centerCoordinate.longitude = location.coordinate.longitude
        mapView.camera = camera
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
