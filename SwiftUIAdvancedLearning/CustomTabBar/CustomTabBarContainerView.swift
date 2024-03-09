//
//  CustomTabBarContainerView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI
// Apple's way of building TabView
/*
struct TabView<SelectionValue, Content> : View where SelectionValue: Hashable, Content: View {
    
}
 */

// using generics and @viewbuilder to create a container of child content and tabbar
// handling the logic of storing child content's corresponding TabBarItem with preference key
struct CustomTabBarContainerView<Content: View>: View {
    // the selected TabBarItem passed from parent view
    @Binding var selection: TabBarItem
    let content: Content
    // a list of tabbaritem passed from the caller
    @State private var tabs: [TabBarItem] = []
    
    // @viewbuilder lets you use closure to pass in a view
    init(selection: Binding<TabBarItem>, @ViewBuilder content: () -> Content) {
        // @Binding can be accessed with 3 variables:
        /*
         1. self._selection is the Binding<TabBarItem> struct itself
         2. self.selection = self._selection.wrappedValue, is a TabBarItem type
         3. self.$selction = self._selection.projectedValue, is also a Binding<TabBarItem> passing down to child
         */
        // receiving the binding from parent view
        self._selection = selection
        self.content = content()
    }
    
    var body: some View {
        ZStack(alignment: .bottom) {
            // the passed content from parent view
            content.ignoresSafeArea(edges: [.top, .bottom])
            // the custom TabBar view
            CustomTabBarView(tabs: tabs, selection: $selection, localSelection: selection)
        }
        // when content view appending its corresponding TabBarItem, store it in container
        .onPreferenceChange(TabBarItemsPreferenceKey.self, perform: { value in
            self.tabs = value
        })
    }
}

#Preview {
    let tabs: [TabBarItem] = [.home, .favorites, .profile]
    return CustomTabBarContainerView(selection: .constant(tabs.first!)) {
        Color.red
            .tabBarItem(tab: .home, selection: .constant(tabs.first!))
        Color.green
            .tabBarItem(tab: .favorites, selection: .constant(tabs.first!))
        Color.blue
            .tabBarItem(tab: .profile, selection: .constant(tabs.first!))
    }
}
