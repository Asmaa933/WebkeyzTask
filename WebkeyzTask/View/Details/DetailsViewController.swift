//
//  DetailsViewController.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import UIKit
import SDWebImage
import MapKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private weak var hotelImage: UIImageView!
    // 0 hotel name 1 address 2 low price 3 high price
    @IBOutlet private var labelsArray: [UILabel]!
    @IBOutlet private weak var mapView: MKMapView!
    
    private var viewModel = HotelsViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImage()
    }
    override func viewWillAppear(_ animated: Bool) {
        setupView()
        navigationItem.title = "Details"
    }
    
    func setupView() {
        self.updateUI(hotel: viewModel.getSelectedHotel())
    }
}

fileprivate extension DetailsViewController {
    func updateUI(hotel: HotelModel?) {
        hotelImage.sd_setImage(with: URL(string: hotel?.image?[0].url ?? ""), placeholderImage: #imageLiteral(resourceName: "placeholder"))
        labelsArray[0].text = hotel?.hotelName ?? ""
        labelsArray[1].text = hotel?.address ?? ""
        labelsArray[2].text = "\(hotel?.lowRate ?? 0)"
        labelsArray[3].text = "\(hotel?.highRate ?? 0)"
        updateMap()
    }
    
    func setupImage() {
        hotelImage.layer.cornerRadius = 10
        hotelImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped)))
    }
    
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
    
    @objc func dismissFullscreenImage(_ gesture: UITapGestureRecognizer) {
        self.navigationController?.isNavigationBarHidden = false
        gesture.view?.removeFromSuperview()
    }
    
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
