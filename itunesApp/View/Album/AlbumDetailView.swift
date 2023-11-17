//
//  AlbumDetailView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct AlbumDetailView: View {
    
    let album: AlbumModel
    @StateObject var songsListViewModel: SongsForAlbumListViewModel
    
    init(album: AlbumModel) {
        self.album = album
        self._songsListViewModel = StateObject(wrappedValue: SongsForAlbumListViewModel(albumID: album.id))
    }
    
    var body: some View {
        VStack {
            AlbumHeaderDetailView(album: album)
            
            SongsForAlbumListView(songsListViewModel: songsListViewModel, selectedSong: nil)
        } 
        .onAppear {
            songsListViewModel.fetch()
        }
    }
    
 
}



struct AlbumHeaderDetailView: View {
    
    let album: AlbumModel
    
    var body: some View {
        HStack(alignment: .bottom) {
            ImageLoadingView(urlString: album.artworkUrl100, size: 100)
            
            VStack(alignment: .leading) {
                
                Text(album.collectionName)
                    .font(.footnote)
                    .foregroundStyle(Color.black)
                Text(album.artistName)
                    .padding(.bottom, 5)
                
                Text(album.primaryGenreName)
                Text("\(album.trackCount) songs")
                Text("Released: \( formattedDate(value: album.releaseDate))")
                
            }
            .font(.caption)
            .foregroundStyle(Color.gray)
            .lineLimit(1)
            
            Spacer(minLength: 50)
            
            BuyButton(urlString: album.collectionViewURL, price: album.collectionPrice, currency: album.currency)
            
        } 
        .padding()
        .background(Color(.systemBackground).edgesIgnoringSafeArea(.top).shadow(radius: 5))
    }
    
    func formattedDate(value: String) -> String {
        let dateFormtterGetter = DateFormatter()
        dateFormtterGetter.dateFormat = "yyy-MM-dd'T'HH:mm:ss'Z'"
        
        guard let date = dateFormtterGetter.date(from: value) else {
            return ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        
        return dateFormatter.string(from: date)
        
    }
}

#Preview {
    AlbumDetailView(album: AlbumModel.example())
}
