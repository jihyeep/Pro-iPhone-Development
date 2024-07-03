//
//  ContentView.swift
//  SearchApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI

enum ProductScope {
    case fruit
    case vegetable
}

struct ContentView: View {
    @State var searchText = ""
    @State private var scope: ProductScope = .fruit
    
    let petArray = ["Cat", "Dog", "Fish", "Donkey", "Canary", "Camel", "Frog"]
    
    let scopes = ["All", "Favorites", "Recent"]
    
    var body: some View {
        NavigationStack {
            PetListView(animals: petArray)
                .navigationTitle("SearchApp")
        }
        .navigationBarTitleDisplayMode(.automatic)
        .searchable(text: $searchText,
                    placement: .navigationBarDrawer(displayMode: .always), /// 검색바 항상 띄우기
                    prompt: "Look for a pet") {
            
            // suggestions
//            Text("Singing").searchCompletion("Canary")
//            Text("Funny").searchCompletion("Canary")
//            Text("Croaking").searchCompletion("Frog")
//            Text("Grumpy").searchCompletion("Cat")
            Spacer() // searchable의 리스트를 가려서 검색창을 눌렀을 때도 리스트가 안보이게 됨(아래 !searchText.isEmpty && 도 줘야 함)
            
            // 앞부터 매칭이 되는 것만 필터링
            /// searchText 가 비었을 경우, hasPrefix는 true를 리턴
            /// -> 배열의 모든 요소가 출력됨
            ForEach(petArray.filter { !searchText.isEmpty && $0.hasPrefix(searchText) }, id: \.self) { name in
                Text(name)
            }
        }
                    .searchScopes($scope) {
                        Text("Fruit").tag(ProductScope.fruit)
                        Text("Vegetable").tag(ProductScope.vegetable)
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
                .background(.yellow)
        }
//        .listStyle(.plain)
    }
}
