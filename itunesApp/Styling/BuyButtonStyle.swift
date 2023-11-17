//
//  BuyBottonStyle.swift
//  itunesApp
//
//  Created by Emmanuel Agene on 15/11/2023.
//

import SwiftUI



struct BuyButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundStyle(Color.accentColor)
            .padding(5)
            .padding(.horizontal, 10)
            .padding(.vertical, 5)
            .overlay {
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.accentColor,lineWidth: 1)
                    
            }
            .opacity(configuration.isPressed ? 0.5 : 1)
    }
}


//
//#Preview {
//    BuyButtonStyle() as! any View
//    
//}
