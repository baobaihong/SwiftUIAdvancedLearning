//
//  AppNavBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/9.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Next Screen")
                        .customNavigationTitle("Second Screen")
                        .customNavigationSubtitle("Second Subtitle")
                ) {
                    Text("Navigate")
                }

            }
            .customNavBarItems(title: "First Screen", subtitle: "First subtitle", backButtonHidden: true)
        }
    }
}

extension AppNavBarView {
    private var defaultNavView: some View {
        NavigationStack {
            ZStack {
                Color.green.ignoresSafeArea()
                
                NavigationLink {
                    Text("Next Screen")
                        .navigationTitle("Title 2")
                        .navigationBarBackButtonHidden(false)
                } label: { Text("Navigate") }
            }
            .navigationTitle("Nav title here")
        }
    }
}

#Preview {
    AppNavBarView()
}
