//
//  ButtonStyleBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/6.
//

import SwiftUI

struct PressableButtonStyle: ButtonStyle {
    let scaledAmount: CGFloat
    
    init(scaledAmount: CGFloat) {
        self.scaledAmount = scaledAmount
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? scaledAmount : 1.0)
            .brightness(configuration.isPressed ? 0.1 : 0)
            //.opacity(configuration.isPressed ? 0.9 : 1.0)
    }
}

extension View {
    func withPressableStyle(scaledAmount: CGFloat = 0.9) -> some View {
        buttonStyle(PressableButtonStyle(scaledAmount: scaledAmount))
    }
}

struct ButtonStyleBootcamp: View {
    var body: some View {
        // Button View has a default click-highlight effect
        Button(action: {
            
        }, label: {
            Text("Button")
                .font(.headline)
                .withDefaultButtonFormatting()
        })
        //.buttonStyle(PressableButtonStyle()) // <- use button style provided by Apple to change a little bit.
        .withPressableStyle()
        .padding()
    }
}

#Preview {
    ButtonStyleBootcamp()
}
