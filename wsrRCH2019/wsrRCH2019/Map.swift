//
//  Map.swift
//  wsrRCH2019
//
//  Created by Admin on 30.11.2020.
//
import MapKit
import SwiftUI


struct MapView: UIViewRepresentable {
    
    @State var mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        //let mapView = MKMapView()
        mapView.delegate = context.coordinator
        
        let annotation = MKPointAnnotation()
        annotation.title = "Moscow"
        annotation.subtitle = "My City"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55.7, longitude: 37.6)
        mapView.addAnnotation(annotation)
        
        addAnnotation()
        
        
       // mapView.addAnnotation(MKAnnotation)
        return mapView
    }
    func addAnnotation() {
        let annotation = MKPointAnnotation()
        annotation.title = "Moscow2"
        annotation.subtitle = "My City2"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 55, longitude: 37)
        mapView.addAnnotation(annotation)
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        //
    }
    class Coordinator: NSObject, MKMapViewDelegate{
        var parent: MapView
        
        func mapViewDidChangeVisibleRegion(_ mapView: MKMapView) {
            print(mapView.centerCoordinate)
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
            let view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: nil)
            view.canShowCallout = true
            return view
        }
        
        init(_ parent: MapView){
            self.parent = parent
        }
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
}


