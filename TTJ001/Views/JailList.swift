//
//  JailList.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/14/21.
//

import SwiftUI
import Foundation
import UIKit
import MapKit
import CoreLocation  //enables User Location


var test: [String] = ["hi1", "hi2", "hi3", "hi4", "hi5", "hi6", "hi7", "hi8", "hi9", "hi10", "hi11", "hi12", ]



struct JailList: View {
    var body: some View {
        NavigationView {
            List {
            NavigationLink(
                destination: /*@START_MENU_TOKEN@*/Text("Destination")/*@END_MENU_TOKEN@*/,
                label: {
                    /*@START_MENU_TOKEN@*/Text("Navigate")/*@END_MENU_TOKEN@*/
                })
            Group{
            JailRow(town: test[1])
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Alvin")
            JailRow(town: "Alvin")
            JailRow(town: "Alvin")
            }
            Group{
            JailRow(town: test[2])
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Pearland")
            JailRow(town: "Alvin")
            JailRow(town: "Alvin")
            JailRow(town: "Alvin")
            JailRow(town: "Galveston")
            }
        }.navigationTitle("Towns")
        }
        
    }
}

struct JailList_Previews: PreviewProvider {
    static var previews: some View {
        JailList()
    }
}


