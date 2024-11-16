//
//  VacationApp.swift
//  Vacation
//
//  Created by 李佳骏 on 2024/11/13.
//

import SwiftUI

struct Scrollimage: View {
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFit()
            .clipShape(.rect(cornerRadius: 20))
            .scrollTransition { content, phase in
                content
                    .scaleEffect(phase.isIdentity ? 1 : 0.5)
                    .opacity(phase.isIdentity ? 1 : 0.5)
            }
        .enableInjection()
    }

    #if DEBUG
    @ObserveInjection var forceRedraw
    #endif
}

#Preview {
    Scrollimage(image: "bellagio")
}
