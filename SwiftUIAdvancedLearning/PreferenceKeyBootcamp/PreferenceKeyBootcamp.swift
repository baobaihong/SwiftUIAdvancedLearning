//
//  PreferenceKeyBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

struct PreferenceKeyBootcamp: View {
    @State private var text: String = "hello world!"
    
    var body: some View {
        NavigationStack {
            VStack {
                SecondaryView(text: text)
                    .navigationTitle("Navigation Title") // <- this modifier actually changes the data in parent view
                    //.customTitle("new value")
            }
             
        }
        // when receiving the signal from child view, update the text in SecondaryView
        .onPreferenceChange(CustomTitlePreferenceKey.self, perform: { value in
            self.text = value
        })
    }
}


// the child view
struct SecondaryView: View {
    
    let text: String
    @State private var newValue: String = "downloading..."
    
    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue) // <- call to change perference key with newValue
    }
    // mimic the process of downloading data and map the value into newValue
    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: DispatchWorkItem(block: {
            self.newValue = "new value from downloading data"
        }))
    }
}

// create an extension enables view type to call a function to change perference key
extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct CustomTitlePreferenceKey: PreferenceKey {
    static let defaultValue: String = ""
    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}

#Preview {
    PreferenceKeyBootcamp()
}
