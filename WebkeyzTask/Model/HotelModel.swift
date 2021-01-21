//
//  HotelModel.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import ObjectMapper

//"hotel": [
//{
//"hotelId": 4020979,
//"image": [
//{
//"url": "https://az712897.vo.msecnd.net/images/full/A1EE945E-166C-4AC0-BB73-00B1D8F5DEF0.jpeg"
//}
//],
//"location": {
//"address": "Burj Nahar Roundabout, Naif Road,",
//"latitude": 25.275914,
//"longitude": 55.313262
//},
//"summary": {
//"highRate": 6386.04,
//"hotelName": "Coral Oriental Dubai",
//"lowRate": 4958.58
//}
//}
//]

/// Hotel Model

class HotelModel: Mappable {
    
    //MARK:- Variables
    
    var hotelId: Int?
    var image: [HotelImage]?
    var address: String?
    var latitude: Double?
    var longitude: Double?
    var highRate: Double?
    var hotelName: String?
    var lowRate: Double?
    
    //MARK: - Initializer

    required init?(map: Map) {}
    
    //MARK: - Mapping

    func mapping(map: Map) {
        hotelId                  <- map["hotelID"]
        image                    <- map["image"]
        address                  <- map["location.address"]
        latitude                 <- map["location.latitude"]
        longitude                <- map["location.longitude"]
        highRate                 <- map["summary.highRate"]
        hotelName                <- map["summary.hotelName"]
        lowRate                  <- map["summary.lowRate"]
    }
}

/// HotelImage
class HotelImage: Mappable {
    
    //MARK:- Variables

    var url: String?
    
    //MARK: - Initializer
    
    required init?(map: Map) {}
    
    //MARK: - Mapping
    
    func mapping(map: Map) {
        url <- map["url"]
    }
}
