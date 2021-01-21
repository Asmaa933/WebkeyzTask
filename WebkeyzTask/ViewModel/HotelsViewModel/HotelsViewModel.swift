//
//  HotelsViewModel.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import Foundation
import RxSwift
import RxCocoa

protocol HotelsViewModelProtocol {
    var  hotelsDriver : Driver<[HotelModel]> {set get}
    var errorDriver: Driver<String> {set get}
    func fetchHotels()
}

class HotelsViewModel: HotelsViewModelProtocol  {
    
    var hotelsDriver: Driver<[HotelModel]>
    var errorDriver: Driver<String>
    
    private var disposeBag = DisposeBag()
    private let apiHandler : ApiHandlerProtocol = ApiHandler()
    private var hotelsObservable: Observable<[HotelModel]>?
    
    var errorSubject: PublishSubject<String> = PublishSubject()
    var hotelSubject: PublishSubject<[HotelModel]> = PublishSubject()
    
    init() {
        hotelsDriver = hotelSubject.asDriver(onErrorJustReturn: [])
        errorDriver = errorSubject.asDriver(onErrorJustReturn: "")
    }
    
    func fetchHotels() {
        hotelsObservable = apiHandler.getHotels()
        hotelsObservable?.subscribe(onNext: {[weak self] (hotels) in
            self?.hotelSubject.onNext(hotels)
        }, onError: {[weak self] (error) in
            self?.errorSubject.onNext(error.localizedDescription.description)
        }).disposed(by: disposeBag)
    }
}

fileprivate extension HotelsViewModel {
    
}
