//
//  SongSection.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct SongSectionView: View {
    
    let songs: [SongModel]
    let rows = Array(repeating: GridItem(.fixed(60), spacing: 0, alignment: .leading), count: 4)
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, spacing: 15) {
                ForEach(songs) { song in
                    
                    NavigationLink {
                        SongDetailView(song: song)
                    } label: {
                        SongRowView(song: song)
                            .frame(width: 300)
                    } .buttonStyle(.plain)
                        
                    
                }
            } .padding(.horizontal)
        }
    }
}

#Preview {
    SongSectionView(songs: [SongModel.example()])
}
