//
//  UnitTestingBootcampView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/11.
//

/*
 1. Unit Tests:
 - test the underlying logic in your app (e.g. ViewModels, data services, utilities)

 2. UI Tests:
 - tests the UI of your app
 
 
 */

import SwiftUI

struct UnitTestingBootcampView: View {
    @State var vm: UnitTestingBootcampViewModel
    
    init(isPremium: Bool) {
        self._vm = State(wrappedValue: UnitTestingBootcampViewModel(isPremium: isPremium))
    }
    
    var body: some View {
        Text(vm.isPremium.description)
    }
}

#Preview {
    UnitTestingBootcampView(isPremium: true)
}
