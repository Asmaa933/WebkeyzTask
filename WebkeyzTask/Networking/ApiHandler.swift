//
//  ApiHandler.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import Foundation
import Alamofire
import RxSwift
import ObjectMapper
import Network


protocol ApiHandlerProtocol {
    func getHotels() -> Observable<[HotelModel]>
}

/// Handle Api calls
class ApiHandler: ApiHandlerProtocol {
    
    //Get Hotels from Api
    func getHotels() -> Observable<[HotelModel]>{
        let monitor = NWPathMonitor()
        var request: DataRequest?
        return Observable.create { (observer) -> Disposable in
            monitor.pathUpdateHandler = { path in
                if path.status == .satisfied {
                    request = AF.request(Constants.baseURL).responseJSON { (response) in
                        switch response.result {
                        case .success(let value):
                            guard let jsonResponse = value as? [String:Any] else {
                                let error = NSError(domain: Constants.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.generalError])
                                observer.onError(error)
                                return
                            }
                            let mapObject = Mapper<BaseModel>().map(JSON: jsonResponse)
                            observer.onNext(mapObject?.hotels ?? [])
                            observer.onCompleted()
                        case .failure(let error):
                            print(error.localizedDescription.description)
                            let error = NSError(domain: Constants.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.generalError])
                            observer.onError(error)
                        }
                    }
                } else {
                    let error = NSError(domain: Constants.baseURL, code: 0, userInfo: [NSLocalizedDescriptionKey: Constants.internetConnectionError])
                    observer.onError(error)
                }
            }
            let queue = DispatchQueue(label: "Monitor")
            monitor.start(queue: queue)
            monitor.cancel()
            
            return Disposables.create {
                request?.cancel()
            }
        }
    }
}
