//
//  ListView.swift
//  WatchOS WatchKit Extension
//
//  Created by Kaavya on 2022-03-11.
//

import Foundation
import SwiftUI

struct ListView: View {
    
    var body: some View {
        VStack{
            List {
                NavigationLink("Microsoft",destination: ContentView(stockString: "Microsoft"))
                NavigationLink("Tesla",destination: ContentView(stockString: "Tesla"))
                NavigationLink("Amazon",destination: ContentView(stockString: "Amazon"))
                NavigationLink("Google",destination: ContentView(stockString: "Google"))
                NavigationLink("Nvidia",destination: ContentView(stockString: "Nvidia"))
                NavigationLink("Starbucks",destination: ContentView(stockString: "Starbucks"))
                NavigationLink("Facebook", destination: ContentView(stockString: "Facebook"))
                NavigationLink("Netflix", destination: ContentView(stockString: "Netflix"))
                NavigationLink("Peloton", destination: ContentView(stockString: "Peloton"))
                NavigationLink("Micron", destination: ContentView(stockString: "Micron"))
            }.navigationTitle("Stocks")
        }
    }
}
