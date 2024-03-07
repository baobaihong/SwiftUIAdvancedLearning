//
//  MatchedGeometryEffectBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/7.
//

import SwiftUI

struct MatchedGeometryEffectBootcamp: View {
    @State private var isClicked: Bool = false
    @Namespace private var  namespace
    
    var body: some View {
        VStack {
            if !isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace) // with the same id, SwiftUI will treat two shapes as the same one and animate
                    .frame(width: 100, height: 100)
                //.offset(y: isClicked ? UIScreen.main.bounds.height * 0.75 : 0)
            }
            
            
            Spacer()
            
            if isClicked {
                RoundedRectangle(cornerRadius: 25)
                    .matchedGeometryEffect(id: "rectangle", in: namespace)
                    .frame(width: 300, height: 200)
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white)
        .onTapGesture {
            withAnimation(.easeInOut) {
                isClicked.toggle()
            }
        }
    }
}

struct MatchedGeometryEffectExample2: View {
    let category: [String] = ["Home", "Popular", "Saved"]
    @State private var selected = ""
    @Namespace private var namespace2
    
    var body: some View {
        HStack {
            ForEach(category, id: \.self) { category in
                ZStack(alignment: .bottom) {
                    if selected == category {
                        RoundedRectangle(cornerRadius: 10)
                            .fill(Color.red.opacity(0.5))
                            .matchedGeometryEffect(id: "category_background", in: namespace2)
                            .frame(width: 35, height: 2)
                            .offset(y: 10.0)
                    }
                    
                    Text(category)
                        .fontWeight(selected == category ? .bold : .regular)
                        .foregroundStyle(selected == category ? .red : .black)
                    
                    
                }
                .frame(maxWidth: .infinity)
                .frame(height: 55)
                .onTapGesture {
                    withAnimation(.spring()) {
                        selected = category
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    MatchedGeometryEffectExample2()
}
