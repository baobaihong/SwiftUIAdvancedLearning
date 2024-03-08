//
//  ViewBuilderBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

struct HeaderViewRegular: View {
    let title: String
    let description: String?
    let iconName: String?
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            if let description = description {
                Text(description)
                    .font(.callout)
            }
            if let iconName = iconName {
                Image(systemName: iconName)
            }
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct HeaderViewGeneric<Content: View>: View {
    
    let title: String
    let content: Content
    
    // to make the property 'content' act like HStack, use ViewBuilder parameter attribute to constructs views from closures
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.largeTitle)
                .fontWeight(.semibold)
            
            content
            
            RoundedRectangle(cornerRadius: 5)
                .frame(height: 2)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

struct CustomHStack<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        content
    }
}

struct ViewBuilderBootcamp: View {
    var body: some View {
        HeaderViewRegular(title: "New Title", description: "description", iconName: "heart.fill")
        HeaderViewRegular(title: "another title", description: nil, iconName: nil)
        HeaderViewGeneric(title: "Generic 1") {
            VStack(alignment: .leading) {
                Text("hi")
                Text("world")
            }
        }
        
        CustomHStack {
            Text("hi")
            Text("world")
        }
        
        LocalViewBuilder(type: .three)
        
        Spacer()
    }
}

struct LocalViewBuilder: View {
    enum ViewType {
        case one, two, three
    }
    let type: ViewType
    
    var body: some View {
        VStack {
            headerSection
        }
    }
    
    // @ViewBuilder enables the computed property to output different views under conditions
    @ViewBuilder private var headerSection: some View {
        switch type {
        case .one: viewOne
        case .two: viewTwo
        case .three: viewThree
        }
    }
    
    private var viewOne: some View {
        Text("one")
    }
    
    private var viewTwo: some View {
        VStack {
            Text("two")
            Image(systemName: "heart.fill")
        }
    }
    
    private var viewThree: some View {
        Image(systemName: "heart.fill")
    }
}

#Preview {
    ViewBuilderBootcamp()
}
