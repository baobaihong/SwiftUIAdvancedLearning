//
//  SwiftUIAdvancedLearningApp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/6.
//

import SwiftUI

@main
struct SwiftUIAdvancedLearningApp: App {
    
    let currentUserIsSignedIn: Bool
    
    init() {
        // Edit Scheme -> Add Argument passed on launch
        // Approach1: Use CommaneLine to access
        //let userIsSignedIn: Bool = CommandLine.arguments.contains("-UITest_startSignedIn") ? true : false
        
        // Approach2: Use PrecessInfo to access
        let userIsSignedIn: Bool = ProcessInfo.processInfo.arguments.contains("-UITest_startSignedIn") ? true : false
        
        // Approach3: add environment key-value pair, note that the value is of type String
        //let value = ProcessInfo.processInfo.environment["-UITest_startSignedIn2"]
        //let userIsSignedIn: Bool = value == "true" ? true : false
        self.currentUserIsSignedIn = userIsSignedIn
    }
    
    var body: some Scene {
        WindowGroup {
            UITestingBootcampView(currentUserIsSignedIn: currentUserIsSignedIn)
        }
    }
}
