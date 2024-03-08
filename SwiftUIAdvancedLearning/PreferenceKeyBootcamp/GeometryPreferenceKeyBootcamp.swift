//
//  GeometryPreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

struct GeometryPreferenceKeyBootcamp: View {
    @State private var rectSize: CGSize = .zero
    
    var body: some View {
        VStack {
            Text("Hello, World!")
                .frame(width: rectSize.width, height: rectSize.height) // set the frame = size of the rectangle
                .background(Color.blue)
            Spacer()
            HStack {
                ForEach(0..<3) { _ in
                    GeometryReader { geo in
                        Rectangle() // <- size of the rectangle changes according to devices
                            .updateRectangleGeoSize(geo.size)
                    }
                }
            }
            .frame(height: 55)
        }
        .onPreferenceChange(RectangleGeometrySizePreferenceKey.self, perform: { value in
            self.rectSize = value
        })
    }
}

extension View {
    func updateRectangleGeoSize(_ size: CGSize) -> some View {
        preference(key: RectangleGeometrySizePreferenceKey.self, value: size)
    }
}

struct RectangleGeometrySizePreferenceKey: PreferenceKey {
    static var defaultValue: CGSize = .zero
    
    static func reduce(value: inout CGSize, nextValue: () -> CGSize) {
        value = nextValue()
    }
}

#Preview {
    GeometryPreferenceKeyBootcamp()
}
