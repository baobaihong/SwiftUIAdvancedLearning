//
//  CustomTabBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

// Custom TabBar View and switch logic
struct CustomTabBarView: View {
    let tabs: [TabBarItem]
    // changing the selection when switching to another tab, telling the parent view to change the content
    @Binding var selection: TabBarItem
    @Namespace private var namespace
    // animating the tab switch solely
    @State var localSelection: TabBarItem
    
    var body: some View {
        tabBarVersion2
            .onChange(of: selection) { _, newValue in
                withAnimation(.easeInOut) {
                    localSelection = newValue
                }
            }
    }
}

// default style version
extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(selection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(selection == tab ? tab.color.opacity(0.2) : Color.clear)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
    
//    private func switchToTab(tab: TabBarItem) {
//            selection = tab
//    }
    
    private var tabBarVersion1: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture { switchToTab(tab: tab) }
            }
        }
        .padding(6)
        .background(Color.white)
    }
}

// capsule style version
extension CustomTabBarView {
    private func tabView2(tab: TabBarItem) -> some View {
        VStack {
            Image(systemName: tab.iconName)
                .font(.subheadline)
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
        }
        .foregroundStyle(localSelection == tab ? tab.color : Color.gray)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                if localSelection == tab {
                    Capsule().fill(tab.color.opacity(0.2)).matchedGeometryEffect(id: "background_rect", in: namespace)
                }
            }
        )
    }
    
    
    private func switchToTab(tab: TabBarItem) {
            selection = tab
    }
    
    private var tabBarVersion2: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView2(tab: tab)
                    .onTapGesture { switchToTab(tab: tab) }
            }
        }
        .padding(6)
        .background(.thickMaterial)
        .clipShape(Capsule())
        .shadow(color: .black.opacity(0.3), radius: 10, x: 0.0, y: 5.0)
        .padding(.horizontal)
    }
}



#Preview {
    let tabs: [TabBarItem] = [.home, .favorites, .profile]
    return VStack {
        Spacer()
        CustomTabBarView(tabs: tabs, selection: .constant(tabs.first!), localSelection: tabs.first!)
    }
}
