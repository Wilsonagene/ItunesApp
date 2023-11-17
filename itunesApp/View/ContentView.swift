//
//  ContentView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 13/11/2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        TabView {
            
            SearchView()
                .tabItem {
                    Label("Search", systemImage: "doc.text.magnifyingglass")
                }
            
            AlbumSearchView()
                .tabItem {
                    Label("Albums", systemImage: "music.note.tv")
                }
            
            MovieSearchListView()
                .tabItem {
                    Label("Moives", systemImage: "tv")
                }
            
        }
        
    }
}

#Preview {
    ContentView()
}
