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
    func fetchHotels()
    func didSelectHotel(hotel: HotelModel)
    func getSelectedHotel() -> HotelModel?
    func getHotelLocation() -> CLLocationCoordinate2D?
    func reloadHotels()
}

class HotelsViewModel {
    
    static var shared = HotelsViewModel()
    var hotelsDriver: Driver<[HotelModel]>
    var errorSubject: PublishSubject<String> = PublishSubject()

    private var disposeBag = DisposeBag()
    private let apiHandler : ApiHandlerProtocol = ApiHandler()
    private var hotelsObservable: Observable<[HotelModel]>?
    private var selectedHotel: HotelModel?
    private var hotelSubject: PublishSubject<[HotelModel]> = PublishSubject()

    //MARK: - Initializer
    
    private init() {
        hotelsDriver = hotelSubject.asDriver(onErrorJustReturn: [])
    }
}

//MARK: - HotelsViewModel Protocol Implementation

extension HotelsViewModel: HotelsViewModelProtocol {
    
    func fetchHotels() {
        hotelsObservable = apiHandler.getHotels()
        hotelsObservable?.subscribe(onNext: {[weak self] (hotels) in
            self?.hotelSubject.onNext(hotels)
        }, onError: {[weak self] (error) in
            self?.errorSubject.onNext(error.localizedDescription.description)
        }).disposed(by: disposeBag)
    }
    
    func didSelectHotel(hotel: HotelModel) {
        self.selectedHotel = hotel
    }
    
    func getSelectedHotel() -> HotelModel? {
        return selectedHotel
    }
    
    func getHotelLocation() -> CLLocationCoordinate2D? {
        if let latitude = selectedHotel?.latitude,let longitude = selectedHotel?.longitude {
            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            return location
        }
        return nil
    }
    
    
    func reloadHotels() {
        errorSubject.onNext("")
        fetchHotels()
    }
}
