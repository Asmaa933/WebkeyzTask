//
//  DetailsViewController.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import SDWebImage
import MapKit

//MARK: - DetailsViewController

class DetailsViewController: UIViewController {
    
    //MARK: - Outlets
    
    // 0 hotel name 1 address 2 low price 3 high price
    @IBOutlet private var labelsArray: [UILabel]!
    @IBOutlet private weak var hotelImage: UIImageView!
    @IBOutlet private weak var mapView: MKMapView!
    
    //MARK: - Variables
    
    private var viewModel = HotelsViewModel.shared
    
    //MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
}

//MARK: - HelperMethods

fileprivate extension DetailsViewController {
    
    /// Setup UI
    func setupView() {
        navigationItem.title = "Details"
        mapView.layer.cornerRadius = 10
        setupImage()
        self.updateUI(hotel: viewModel.getSelectedHotel())
    }
    
    /// Update Hotel Information
    /// - Parameter hotel: Selected Hotel
    func updateUI(hotel: HotelModel?) {
        hotelImage.sd_setImage(with: URL(string: hotel?.image?[0].url ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        labelsArray[0].text = hotel?.hotelName ?? ""
        labelsArray[1].text = hotel?.address ?? ""
        labelsArray[2].text = "\(hotel?.lowRate ?? 0)"
        labelsArray[3].text = "\(hotel?.highRate ?? 0)"
        updateMap()
    }
    
    /// Make Corner Radius and Add Gesture Recognizer
    func setupImage() {
        hotelImage.layer.cornerRadius = 10
        hotelImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
    
    /// Image Tapped Action
    @objc func imageTapped() {
        let newImageView = UIImageView(frame: CGRect(x: 50, y: 100, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
        newImageView.center = view.center
        newImageView.image = hotelImage.image
        newImageView.backgroundColor = .black
        newImageView.contentMode = .scaleAspectFit
        newImageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
        newImageView.addGestureRecognizer(tap)
        self.view.addSubview(newImageView)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    /// Dismiss Full Screen Image When Tap
    @objc func dismissFullscreenImage(_ gesture: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        gesture.view?.removeFromSuperview()
    }
    
    /// Update Location On MapKit
    func updateMap() {
        guard let coordinate = viewModel.getHotelLocation() else {
            mapView.isHidden = true
            return
        }
        mapView.isHidden = false
        let annotation = MKPointAnnotation()
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.region = region
        annotation.coordinate = coordinate
        annotation.title = viewModel.getSelectedHotel()?.hotelName ?? ""
        mapView.addAnnotation(annotation)
        mapView.mapType = .standard
    }
}
