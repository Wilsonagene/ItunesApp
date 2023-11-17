//
//  BuyButton.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI

struct SongBuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let price  = price {
            BuyButton(urlString: urlString, price: price, currency: currency)
        } else {
            Text("ALBUM ONLY")
                .font(.footnote)
                .foregroundStyle(Color.gray)
        }
    }
}


struct BuyButton: View {
    let urlString: String
    let price: Double?
    let currency: String
    
    var body: some View {
        if let url = URL(string: urlString), 
            let priceText = formattedPrice() {
            Link(destination: url) {
                Text(priceText)
            }
            .buttonStyle(BuyButtonStyle())
        }
    }
    
    func formattedPrice() -> String? {
        
        guard let price = price else {
            return nil
        }
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currency
        
       let priceString =  formatter.string(from: NSNumber(value: price))
        return priceString
    }
    
}

#Preview {
    BuyButton(urlString: "", price: 0.1, currency: "")
}
