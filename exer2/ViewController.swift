//
//  ViewController.swift
//  exer2
//
//  Created by MacStudent on 2020-01-10.
//  Copyright © 2020 MacStudent. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController,CLLocationManagerDelegate, MKMapViewDelegate {
  var just = -1
    var locationManager = CLLocationManager()
    @IBOutlet weak var mapView: MKMapView!
    static  var coord : [CLLocationCoordinate2D] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        locationManager.delegate = self
        mapView.delegate = self
       locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
     

      let tap = UITapGestureRecognizer(target: self, action:  #selector(onTap(gestureRecognizer:)))
        
        //let uilpgr = UILongPressGestureRecognizer(target: self, action: #selector(longpress))
         
         mapView.addGestureRecognizer(tap)
    }
    
    func addPoliline(){
        
        var point = mapView.annotations.map({$0.coordinate})
        point.append(mapView.annotations.first.map({$0.coordinate})!)
        let polylines = MKPolyline(coordinates: point, count:point.count)
            mapView.addOverlay(polylines)
    }
    
    //add long press gesture
 

    @objc func onTap(gestureRecognizer : UIGestureRecognizer){
           
        if gestureRecognizer.state == .ended{
        let touchpoint = gestureRecognizer.location(in: mapView)
         let  coordinate = mapView.convert(touchpoint, toCoordinateFrom: mapView)
             let annotation = MKPointAnnotation()
              annotation.title = "city"
              annotation.coordinate = coordinate
            if (annotation.coordinate.latitude - 5000...annotation.coordinate.latitude + 5000).contains(coordinate.latitude) && (annotation.coordinate.longitude - 5000...annotation.coordinate.longitude + 5000).contains(coordinate.longitude){
                
           
                
                mapView.removeAnnotation(annotation)
                mapView.removeOverlays(mapView.overlays)
           
                
            }
        mapView.addAnnotation(annotation)
        addPoliline()
        }
       }
    
    
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {

                let renders = MKPolylineRenderer(overlay: overlay)
               renders.lineWidth = 4
               renders.strokeColor = UIColor.black
               return renders
           
          
       }

    

}

