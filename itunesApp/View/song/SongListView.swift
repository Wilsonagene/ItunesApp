//
//  SongListView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 14/11/2023.
//

import SwiftUI

struct SongListView: View {
    @ObservedObject var viewModel: SongViewModel
    
    var body: some View {
        
            List {
            ForEach  (viewModel.songs) { song in
                NavigationLink {
                    SongDetailView(song: song)
                } label: {
                    SongRowView(song: song)
                } .buttonStyle(.plain)
            }
                
                switch viewModel.state {
                    case .empty:
                    Color.clear
                        .onAppear {
                            viewModel.loadMore()
                        }
                case .isLoding:
                    ProgressView()
                        .progressViewStyle(.circular)
                        .frame(maxWidth: .infinity)
                    
                case .loadedAll:
                    EmptyView()
                case .error(let message):
                    Text(message)
                        .foregroundStyle(.red)
                }
            }
            .listStyle(.plain)
    }
}

#Preview {
    SongListView(viewModel: SongViewModel.example())
}


