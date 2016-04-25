//
//  FourthViewController.swift
//  Physioworks
//
//  Created by Alanna Curran on 21/04/2016.
//  Copyright © 2016 Alanna Curran. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FourthViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate
{
    
    @IBOutlet weak var theMapView: MKMapView!
    
    // Variable for user location
    let locationManager = CLLocationManager()
    
    // Variable for the directions
    var destination:MKMapItem = MKMapItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // User location code
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        // N53.337381, E-9.180464
        let latitude:CLLocationDegrees = 53.337381
        let longditude:CLLocationDegrees = -9.180464
        
        // Will determine how zoomed in the map is.
        let latDelta:CLLocationDegrees = 0.01
        let longDelta:CLLocationDegrees = 0.01
        
        // Helps ensure zoom area is correct.
        let theSpan:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, longDelta)
        
        // The actual location.
        let clinicLocation:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longditude)
        
        // The region.
        let theRegion:MKCoordinateRegion = MKCoordinateRegionMake(clinicLocation, theSpan)
        
        // Displays the map.
        self.theMapView.setRegion(theRegion, animated: true)
        
        // Sets up a pin to show where the clinic is.
        let thePhysioworksAnnotation = MKPointAnnotation()
        thePhysioworksAnnotation.coordinate = clinicLocation
        thePhysioworksAnnotation.title = "Physioworks, Sports & Spinal Clinic"
        thePhysioworksAnnotation.subtitle = "2 Garrai Mhe, Mountain Road Moycullen, Co. Galway, H91 Y9YE"
        
        // Places the pin on the map.
        self.theMapView.addAnnotation(thePhysioworksAnnotation)
        
        
        let placeMark = MKPlacemark(coordinate: clinicLocation, addressDictionary: nil)
        destination = MKMapItem(placemark: placeMark)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations.last
        
        
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        print("Errors: " + error.localizedDescription)
    }
    
    @IBAction func btnDirections(sender: UIButton) {
        // Creating an MKDirection Request.
        let request = MKDirectionsRequest()
        request.source = MKMapItem.mapItemForCurrentLocation()
        
        request.destination = destination
        request.requestsAlternateRoutes = false
        
        let directions = MKDirections(request: request)

        directions.calculateDirectionsWithCompletionHandler(
            {(response , error ) in
        
            if error != nil {
                print("Error \(error)")
            } else {
                
                let overlays = self.theMapView.overlays
                self.theMapView.removeOverlays(overlays)
                
                for route in response!.routes {
                    self.theMapView.addOverlay(route.polyline, level: MKOverlayLevel.AboveRoads)
                    for next in route.steps {
                        print(next.instructions)
                    }// End of inner for
                }// End of outer for
                
            }// End of if else
        })// End of calculateDirectionsWithCompletionHandler
    }// End of btnDirections
    
    func mapView(mapView: MKMapView, rendererForOverlay overlay: MKOverlay) -> MKOverlayRenderer {
        let draw = MKPolylineRenderer(overlay: overlay)
        draw.strokeColor = UIColor.purpleColor()
        draw.lineWidth = 3.0
        return draw
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}