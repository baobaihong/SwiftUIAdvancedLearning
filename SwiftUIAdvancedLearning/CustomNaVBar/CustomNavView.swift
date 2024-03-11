//
//  CustomNavView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/9.
//

import SwiftUI

// you have to make a Content type because View is a protocol instead of type
struct CustomNavView<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        NavigationStack {
            CustomNavBarContainerView {
                content
            }
            .toolbar(.hidden)
        }
    }
}

// bring back the swipe back gesture
extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = nil
    }
}

#Preview {
    CustomNavView {
        Color.red.ignoresSafeArea()
    }
}
