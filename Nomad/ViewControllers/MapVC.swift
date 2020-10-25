//
//  MapVC.swift
//  Nomad
//
//  Created by MD R CHOWDHURY on 10/25/20.
//  Copyright © 2020 MD R CHOWDHURY. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit

class MapVC: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapView: MKMapView!
    
    var baseRef: DatabaseReference!
    
    var currentMode = "Traveler"

    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        baseRef = Database.database().reference()
        setupMapView()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var modeButton: UIButton!
    @IBAction func switchMode(_ sender: UIButton) {
        if (currentMode == "Traveler") {
            modeButton.setImage(UIImage(named: "Streamer"), for: .normal)
            self.currentMode = "Streamer"
        } else {
            modeButton.setImage(UIImage(named: "Traveler"), for: .normal)
            self.currentMode = "Traveler"
        }
    }
    
    

    func setupMapView() {
        baseRef.child("Streamer").observeSingleEvent(of: .value, with: { (snapshot) in
            guard let value = snapshot.value as? [String : Any] else {return}
            
            for streamerDict in value  {
                let userID = streamerDict.key
                let  streamerDictVal = streamerDict.value as? Dictionary<String, Any>
                let streamerLongitude = streamerDictVal?["longitude"] as? Double
                let longInDeg = CLLocationDegrees(streamerLongitude ?? 0.0)
                
                let streamerLatitude = streamerDictVal?["latitude"] as? Double
                let latInDeg = CLLocationDegrees(streamerLatitude ?? 0.0)
                
                let status = streamerDictVal?["status"] as? String
                let name = streamerDictVal?["name"] as? String
                
                let streamer = CustomPointAnnotation()
                streamer.coordinate = CLLocationCoordinate2DMake(latInDeg, longInDeg)
                streamer.title = name
                streamer.subtitle = status
                streamer.imageName = "tourist"
                
                self.mapView.addAnnotation(streamer)
            }
        }) { (error) in
            print("Error HomeVC @fetchUser",error.localizedDescription)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {


        if !(annotation is CustomPointAnnotation) {
            return nil
        }

        let reuseId = "test"

        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView?.canShowCallout = true
        }
        else {
            anView?.annotation = annotation
        }

        //Set annotation-specific properties **AFTER**
        //the view is dequeued or created...

        let cpa = annotation as! CustomPointAnnotation
        anView?.image = UIImage(named:cpa.imageName)

        return anView
    }

}

class CustomPointAnnotation: MKPointAnnotation {
    var imageName: String!
}
