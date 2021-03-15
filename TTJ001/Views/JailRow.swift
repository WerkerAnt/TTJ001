//
//  JailRow.swift
//  TTJ001
//
//  Created by Rodney Hermes on 3/14/21.
//

import SwiftUI
import CoreData
import Foundation
import UIKit




struct JailRow: View {
    
    var town: String
    
    
    var body: some View {
        HStack{
            Text(town)
            Text(town)
            Spacer()
        }.padding(.leading, 10)
        
    }
}


struct JailRow_Previews: PreviewProvider {
    static var previews: some View {
        
        Group{
            JailRow(town: "Alvin")
            JailRow(town: "Pearland")
            JailRow(town: "Katy")
            JailRow(town: "Galveston")
        }.previewLayout(.fixed(width: 300, height: 50))
        
    }
}
