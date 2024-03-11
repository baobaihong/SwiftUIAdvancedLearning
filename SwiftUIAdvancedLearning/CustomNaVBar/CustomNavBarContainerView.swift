//
//  CustomNavBarContainerView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/9.
//

import SwiftUI

struct CustomNavBarContainerView<Content: View>: View {
    let content: Content
    @State private var showBackButton: Bool = true
    @State private var title: String = ""
    @State private var subtitle: String? = nil
    
    init(content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            CustomNavBarView(showBackButton: showBackButton, title: title, subtitle: subtitle)
            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // listening Preference Key change passing from child view
        .onPreferenceChange(CustomNavBarTitlePreferenceKeys.self, perform: { value in
            self.title = value
        })
        .onPreferenceChange(CustomNavBarSubtitlePreferenceKeys.self, perform: { value in
            self.subtitle = value
        })
        .onPreferenceChange(CustomNavBarBackButtonHiddenPreferenceKeys.self, perform: { value in
            self.showBackButton = !value
        })
    }
}

#Preview {
    CustomNavBarContainerView {
        ZStack {
            Color.green.ignoresSafeArea()
            Text("Hello world!")
        }
        .customNavigationTitle("123")
        .customNavigationSubtitle("subtitle")
        .customNavigationBackButtonHidden(true)
    }
}
