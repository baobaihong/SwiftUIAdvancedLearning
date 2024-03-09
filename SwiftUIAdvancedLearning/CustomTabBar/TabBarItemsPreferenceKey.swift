//
//  TabBarItemsPreferenceKey.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import Foundation
import SwiftUI

struct TabBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [TabBarItem] = []
    
    static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
        value += nextValue()
    }
}

// defines a view modifier that modifies the view's corresponding TabBarItem and the currently selected TabBarItem
struct TabBarItemViewModifier: ViewModifier {
    let tab: TabBarItem
    @Binding var selection: TabBarItem
    
    func body(content: Content) -> some View {
        content
            // 1. only show the content when its corresponding TabBarItem is selected
            .opacity(selection == tab ? 1.0 : 0.0)
            // 2. using preference key to appending the TabBarItem defined in child view to parent view
            .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
    }
}

// enables views call the viewmodifier directly instead of .modifier()
extension View {
    func tabBarItem(tab: TabBarItem, selection: Binding<TabBarItem>) -> some View {
        modifier(TabBarItemViewModifier(tab: tab, selection: selection))
    }
}
