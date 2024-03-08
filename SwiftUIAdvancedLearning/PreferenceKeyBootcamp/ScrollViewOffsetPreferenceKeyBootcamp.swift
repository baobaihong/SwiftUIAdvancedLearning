//
//  ScrollViewOffsetPreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

struct ScrollViewOffsetPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

struct ScrollViewOffsetPreferenceKeyBootcamp: View {
    let title: String = "new title here!!!"
    @State private var scrollViewOffset: CGFloat = 0
    
    var body: some View {
        ScrollView {
            VStack {
                titleLayer
                    .opacity(Double(scrollViewOffset) / 75.0)
                    .onScrollViewOffsetChanged { offset in
                        withAnimation(.easeInOut) {
                            self.scrollViewOffset = offset
                        }
                    }
                
                contentLayer
            }
            .padding()
        }
        .overlay {
            Text("\(scrollViewOffset)")
        }
        .overlay(alignment: .top) { navBarLayer.opacity(scrollViewOffset < 30 ? 1.0 : 0.0) }
    }
}

extension View {
    func onScrollViewOffsetChanged(action: @escaping (_ offset: CGFloat) -> Void) -> some View {
        self
            .background(
                GeometryReader { geo in
                    Text("")
                        .preference(key: ScrollViewOffsetPreferenceKey.self, value: geo.frame(in: .global).minY)
                })
            .onPreferenceChange(ScrollViewOffsetPreferenceKey.self, perform: { value in
                action(value)
            })
    }
}

extension ScrollViewOffsetPreferenceKeyBootcamp {
    private var titleLayer: some View {
        Text(title)
            .font(.largeTitle)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var contentLayer: some View {
        ForEach(0..<100) { _ in
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.red.opacity(0.3))
                .frame(width: 300, height: 200)
        }
    }
    
    private var navBarLayer: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 55)
            .background(.blue)
    }
}

#Preview {
    ScrollViewOffsetPreferenceKeyBootcamp()
}
