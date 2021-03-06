//
//  HotelsViewModel.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit

//MARK: HotelsViewModelProtocol

protocol HotelsViewModelProtocol {
    var  hotelsDriver : Driver<[HotelModel]> {set get}
    var  errorDriver : Driver<String> {set get}
    func fetchHotels()
    func didSelectHotel(hotel: HotelModel)
    func getSelectedHotel() -> HotelModel?
    func getHotelLocation() -> CLLocationCoordinate2D?
    func reloadHotels()
}

/// HotelsViewModel
class HotelsViewModel {
    
    //MARK: - Variables
    
    static var shared = HotelsViewModel()
    var hotelsDriver: Driver<[HotelModel]>
    var errorDriver: Driver<String>
    
    private var disposeBag = DisposeBag()
    private let apiHandler : ApiHandlerProtocol = ApiHandler()
    private var hotelsObservable: Observable<[HotelModel]>?
    private var selectedHotel: HotelModel?
    private var hotelSubject: PublishSubject<[HotelModel]> = PublishSubject()
    private var errorSubject: PublishSubject<String> = PublishSubject()
    
    //MARK: - Initializer
    
    private init() {
        hotelsDriver = hotelSubject.asDriver(onErrorJustReturn: [])
        errorDriver = errorSubject.asDriver(onErrorJustReturn: "")
    }
}

//MARK: - HotelsViewModel Protocol Implementation

extension HotelsViewModel: HotelsViewModelProtocol {
    
    /// Get Hotels
    func fetchHotels() {
        hotelsObservable = apiHandler.getHotels()
        hotelsObservable?.subscribe(onNext: {[weak self] (hotels) in
            self?.hotelSubject.onNext(hotels)
        }, onError: {[weak self] (error) in
            self?.errorSubject.onNext(error.localizedDescription.description)
        }).disposed(by: disposeBag)
    }
    
    /// Set Selected Hotel
    /// - Parameter hotel: Selected Hotel
    func didSelectHotel(hotel: HotelModel) {
        self.selectedHotel = hotel
    }
    
    /// Get Selected Hotel
    /// - Returns: Selected Hotel or nil
    func getSelectedHotel() -> HotelModel? {
        return selectedHotel
    }
    
    /// Get Location fot hotel
    /// - Returns: Hotel Coordinate
    func getHotelLocation() -> CLLocationCoordinate2D? {
        if let latitude = selectedHotel?.latitude,let longitude = selectedHotel?.longitude {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            return location
        }
        return nil
    }
    
    /// Fetch Hotel Again
    func reloadHotels() {
        errorSubject.onNext("")
        fetchHotels()
    }
}
