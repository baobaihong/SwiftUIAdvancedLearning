//
//  CustomNavLink.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/9.
//

import SwiftUI

// Custom Navigation Link nesting standard NavigationLink
// the main purpose is to hide the navigation bar
struct CustomNavLink<Label: View, Destination: View>: View {
    let destination: Destination
    let label: Label
    
    init(destination: Destination, @ViewBuilder label: () -> Label) {
        self.destination = destination
        self.label = label()
    }
    var body: some View {
        NavigationLink {
            CustomNavBarContainerView {
                destination
            }
            .toolbar(.hidden) // <- manually hide the navigation bar
        } label: { label }
    }
}

#Preview {
    CustomNavView {
        CustomNavLink(destination: Text("Destination")) {
            Text("Click me")
        }
    }
}
