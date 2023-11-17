//
//  AlbumListView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 13/11/2023.
//

import SwiftUI

struct AlbumListView: View {
    
    @ObservedObject var viewModel: AlbumViewModel
    
    var body: some View {
        
            List {
              ForEach  (viewModel.albums) { album in
                  NavigationLink {
                      AlbumDetailView(album: album)
                  } label: {
                      AlbumRowView(album: album)
                  }

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
    NavigationView  {
        AlbumListView(viewModel: AlbumViewModel.example())
    }
   
}
