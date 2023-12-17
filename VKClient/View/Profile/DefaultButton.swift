//
//  DefaultButton.swift
//  VKClient
//
//  Created by Matsulenko on 05.12.2023.
//

import SwiftUI

struct DefaultButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
            configuration.label
                .padding(16)
                .frame(minWidth: 0, maxWidth: .infinity)
                .background(.accent)
                .foregroundStyle(.white)
                .font(.headline)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .scaleEffect(configuration.isPressed ? 1.2 : 1)
                .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}
