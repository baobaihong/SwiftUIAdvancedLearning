//
//  ViewModifierBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/6.
//

import SwiftUI

// create a custom view modifier by creating a new struct
struct DefaultButtonViewModifier: ViewModifier {
    let backgroundColor: Color // parameter of custom view modifier
    
    func body(content: Content) -> some View {
        content
//            .font(.headline) // <- not all view support .font modifier
            .foregroundStyle(.white)
            .frame(height: 55)
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 10)
            .padding()
    }
}

// extend the View with the modifier to make it more native
extension View {
    func withDefaultButtonFormatting(backgroundColor: Color = .blue) -> some View{
        modifier(DefaultButtonViewModifier(backgroundColor: backgroundColor))
    }
}

struct ViewModifierBootcamp: View {
    var body: some View {
        VStack {
            Text("hello world")
                .withDefaultButtonFormatting()
//                .modifier(DefaultButtonViewModifier())
//                .font(.headline)
//                .foregroundStyle(.white)
//                .frame(height: 55)
//                .frame(maxWidth: .infinity)
//                .background(Color.blue)
//                .clipShape(RoundedRectangle(cornerRadius: 10))
//                .shadow(radius: 10)
//                .padding()
        }
    }
}

#Preview {
    ViewModifierBootcamp()
}
