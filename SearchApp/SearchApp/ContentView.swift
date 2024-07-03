//
//  ContentView.swift
//  SearchApp
//
//  Created by 박지혜 on 7/3/24.
//

import SwiftUI

// searchScope
enum ProductScope {
    case fruit
    case vegetable
}

// tag 검색 예제
struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let tags: [String]
}

struct ContentView: View {
    // MARK: - tag 검색 예제
    @State private var searchText = ""
    
    let pets = [
        Pet(name: "Cat", tags: ["Land"]),
        Pet(name: "Dog", tags: ["Land"]),
        Pet(name: "Fish", tags: ["Water"]),
        Pet(name: "Donkey", tags: ["Land"]),
        Pet(name: "Canary", tags: ["Air"]),
        Pet(name: "Camel", tags: ["Land"]),
        Pet(name: "Frog", tags: ["Water", "Land"])
    ]
    
    var filteredPets: [Pet] {
        if searchText.isEmpty {
            return pets
        } else {
            return pets.filter { $0.name.localizedCaseInsensitiveContains(searchText) || $0.tags.contains(where: { $0.localizedCaseInsensitiveContains(searchText) }) }
        }
    }
    
    var body: some View {
        NavigationStack {
            List(filteredPets) { pet in
                Text(pet.name)
            }
            .navigationTitle("SearchApp")
            .searchable(text: $searchText, prompt: "Look for a pet")
        }
    }
}

// MARK: - Scope 기능 예제
//    @State private var searchText = ""
//    @State private var searchScope = 0
//
//    let fruits = ["Apple", "Banana", "Cherry", "Date", "Fig", "Orange"]
//    let scopes = ["All", "A-M", "N-Z"]
//    
//    var filteredFruits: [String] {
//        let filtered = fruits.filter { searchText.isEmpty || $0.localizedCaseInsensitiveContains(searchText) }
//        switch searchScope {
//        case 1: return filtered.filter { $0.prefix(1).localizedCaseInsensitiveCompare("N") == .orderedAscending }
//        case 2: return filtered.filter { $0.prefix(1).localizedCaseInsensitiveCompare("N") != .orderedAscending }
//        default: return filtered
//        }
//    }
//
//    var body: some View {
//        NavigationStack {
//            List(filteredFruits, id: \.self) { fruit in
//                Text(fruit)
//            }
//            .navigationTitle("Fruits")
//            .searchable(text: $searchText)
//            .searchScopes($searchScope) {
//                ForEach(0..<scopes.count, id: \.self) { index in
//                    Text(scopes[index]).tag(index)
//                }
//            }
//        }
//    }
//}

// MARK: - searchable, suggestions, searchScope
//@State private var scope: ProductScope = .fruit
//
//@State var searchText = ""
//
//let petArray = ["Cat", "Dog", "Fish", "Donkey", "Canary", "Camel", "Frog"]
//
//    var body: some View {
//        NavigationStack {
//            PetListView(animals: petArray)
//                .navigationTitle("SearchApp")
//        }
//        .navigationBarTitleDisplayMode(.automatic)
//        .searchable(text: $searchText,
//                    placement: .navigationBarDrawer(displayMode: .always), /// 검색바 항상 띄우기
//                    prompt: "Look for a pet") {
            
            // suggestions
//            Text("Singing").searchCompletion("Canary")
//            Text("Funny").searchCompletion("Canary")
//            Text("Croaking").searchCompletion("Frog")
//            Text("Grumpy").searchCompletion("Cat")
//            Spacer() // searchable의 리스트를 가려서 검색창을 눌렀을 때도 리스트가 안보이게 됨(아래 !searchText.isEmpty && 도 줘야 함)
            
            // 앞부터 매칭이 되는 것만 필터링
            /// searchText 가 비었을 경우, hasPrefix는 true를 리턴
            /// -> 배열의 모든 요소가 출력됨
//            ForEach(petArray.filter { !searchText.isEmpty && $0.hasPrefix(searchText) }, id: \.self) { name in
//                Text(name)
//            }
//        }
//                    .searchScopes($scope) {
//                        Text("Fruit").tag(ProductScope.fruit)
//                        Text("Vegetable").tag(ProductScope.vegetable)
//                    }
//    }
//}

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
