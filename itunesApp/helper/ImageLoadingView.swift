//
//  ImageLoadingView.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct ImageLoadingView: View {
    
    let urlString: String
    let size: CGFloat
    var body: some View {
        
        AsyncImage(url: URL(string: urlString)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: size)
            case .failure(_):
                Color.gray
                    .frame(width: size)
            case .success(let image):
                image
                    .border(Color.white.opacity(0.8))
            @unknown default:
                EmptyView()
            }
        }
        .frame(height: size)
    }
}

#Preview {
    ImageLoadingView(urlString: "", size: 50)
}
