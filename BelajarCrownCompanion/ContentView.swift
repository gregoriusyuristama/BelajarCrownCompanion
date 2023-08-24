//
//  ContentView.swift
//  BelajarCrownCompanion
//
//  Created by Gregorius Yuristama Nugraha on 8/21/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var data = PhoneDataModel.shared
    var body: some View {
//        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundColor(.accentColor)
//            Text("Hello, world!")
//        }
//        .padding()

        
        VStack{
            HStack{
                Button("Circle") {
                    data.fidgetShape = 0
                    data.session.transferUserInfo(["FidgetShape":data.fidgetShape])
                }
                .foregroundColor(.red)
                Button("Rectangle") {
                    data.fidgetShape = 1
                    data.session.transferUserInfo(["FidgetShape":data.fidgetShape])
                }
                .foregroundColor(.red)
//                Text(" ==> \(data.watchCount)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
