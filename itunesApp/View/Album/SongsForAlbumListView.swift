//
//  SongsForAlbumListView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 16/11/2023.
//

import SwiftUI

struct SongsForAlbumListView: View {
    
    @ObservedObject var songsListViewModel: SongsForAlbumListViewModel
    let selectedSong: SongModel?
    
    var body: some View {
        
        ScrollViewReader { proxy in
            ScrollView {
                if songsListViewModel.state == .isLoding {
                    ProgressView()
                        .progressViewStyle(.circular)
                } else if songsListViewModel.songs.count > 0 {
                    
                    Group {
                        if #available(iOS 16.0, *) {
                            SongGridView(songs: songsListViewModel.songs, selectedSong: selectedSong)
                        } else {
                            SongStackView(songs: songsListViewModel.songs, selectedSong: selectedSong)
                        }
                    }
                    .onAppear {
                            proxy.scrollTo(selectedSong?.trackNumber, anchor: .center)
                        }
                }
            }
        }
    }
}



@available(iOS 16.0, *)
struct SongGridView: View {
    
    let songs: [SongModel]
    let selectedSong: SongModel?
    
    var body: some View {
        Grid(horizontalSpacing: 15) {
            ForEach(songs) { song in
                GridRow {
                    Text("\(song.trackNumber)")
                        .font(.footnote)
                        .gridColumnAlignment(.trailing)
                    
                    Text(song.trackName)
                        .gridColumnAlignment(.leading)
                    Spacer(minLength: 20)
                    
                    Text(formattedDuration(time: song.trackTimeMillis))
                        .font(.footnote)
                    
                    SongBuyButton(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                }
                .foregroundStyle( song == selectedSong ? Color.accentColor : Color(.label))
                .id(song.trackNumber)
                Divider()
                
            }
        } .padding([.vertical, .trailing])
    }
}

// The vew below is used if IOS 16 or up is not avaliable on users device
struct SongStackView: View {
    
    let songs: [SongModel]
    let selectedSong: SongModel?
    
    var body: some View {
        VStack {
            ForEach(songs) { song in
                HStack {
                    Text("\(song.trackNumber)")
                        .font(.footnote)
                        .frame(width: 25, alignment: .trailing)
                    
                    Text(song.trackName)
                        
                    Spacer(minLength: 20)
                    
                    Text(formattedDuration(time: song.trackTimeMillis))
                        .font(.footnote)
                        .frame(width: 40)
                    
                    SongBuyButton(urlString: song.previewURL, price: song.trackPrice, currency: song.currency)
                        .padding(.trailing)
                }
                .foregroundStyle( song == selectedSong ? Color.accentColor : Color(.label))
                .id(song.trackNumber)
                Divider()
                
            }
        }
    }
}


// the function below is used to conver time in to String
   fileprivate func formattedDuration(time: Int) -> String {
        
        let timeInSecond = time / 1000
        
        let interval = TimeInterval(timeInSecond)
        let formatter  = DateComponentsFormatter()
        formatter.zeroFormattingBehavior = .pad
        formatter.allowedUnits = [.minute, .second]
        formatter.unitsStyle = .positional
        
        return formatter.string(from: interval) ?? ""
        
    }


#Preview {
    SongsForAlbumListView(songsListViewModel: SongsForAlbumListViewModel.example(), selectedSong: nil)
//    SongStackView(songs: [SongModel.example2()], selectedSong: nil)
}
