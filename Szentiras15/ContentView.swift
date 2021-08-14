//
//  ContentView.swift
//  Szentiras15
//
//  Created by Gabor Sornyei on 2021. 08. 08..
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .task {
                do {
                let idezet = try await WebService.shared.fetch(book: "Róm", chapter: 16)
                    print(idezet.keres, idezet.valasz.versek.count)
                    let search = try await WebService.shared.search(for: "skarlát")
                    
                    print("Keres", search.fullTextResult?.hitCount)
                } catch {
                    print("Error: ", error)
                }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
