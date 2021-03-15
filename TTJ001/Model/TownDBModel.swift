//
//  TownDBModel.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/15/21.
//

import Foundation
class ContactDBModel {
    
    var jails: [Jail] //Array<Contact>
    
    init (_ section: Int)
    {
        jails = Array<Jail> ()
        loadDatabase(section)
    }
    
    func loadDatabase (_ section: Int) {
        if section == 0 {
            jails.append(Jail())
            
        }else {
           
        }
        
    }
    
    func contactAtIndex(_ idx: Int) -> Jail {
        return jails[idx]
    }
    
    func deleteContactAtIndex(_ idx:Int){
        jails.remove(at: idx)
        
    }
    
    func count() -> Int {
        return jails.count
    }
    
    func addContact(_ c:Jail){
        jails.append(c)
    }
    
    
}
