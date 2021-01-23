//
//  BaseModel.swift
//  WebkeyzTask
//
//  Created by Asmaa Tarek on 1/21/21.
//

import ObjectMapper

/// BaseModel

class BaseModel: Mappable {
    
    //MARK:- Variables

    var hotels: [HotelModel]?
    
    //MARK: - Initializer
    
    required init?(map: Map) {}
    
    //MARK: - Mapping
    
    func mapping(map: Map) {
        hotels <- map["hotel"]
    }
}
