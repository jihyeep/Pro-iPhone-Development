//
//  ContentView.swift
//  SearchApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI

struct ContentView: View {
    @State var searchText = ""
    
    let petArray = ["Cat"]
    
    var body: some View {
        NavigationStack {
            PetListView(animals: petArray)
        }
        .searchable(text: $searchText) {
            ForEach(petArray.filter {
                $0.hasPrefix(searchText) /// 앞부터 매칭이 되는 것만 필터링
            }, id: \.self) { name in
            Text(name)}
        }
    }
}

#Preview {
    ContentView()
}

struct PetListView: View {
    let animals: [String]
    
    var body: some View {
        List(animals, id: \.self) { animal in
            Text(animal)
        }
    }
}
