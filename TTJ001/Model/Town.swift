//
//  Jail.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/15/21.
//

import Foundation

class Town {
    
    var town: String
    var county: String
    
    init (town: String, county: String){
        self.town = town
        self.county = county
    }
    
    func getTown() -> String {
        return town
    }
    
    func getCounty() -> String {
        return county
    }
}
