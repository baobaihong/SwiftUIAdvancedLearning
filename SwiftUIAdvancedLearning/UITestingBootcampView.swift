//
//  UITestingBootcampView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/12.
//

import SwiftUI

@Observable class UITestingBootcampViewModel {
    let placeholderText: String = "Add your name..."
    var textFieldText: String = ""
    var currentUserIsSignedIn: Bool = false
    
    init(currentUserIsSignedIn: Bool) {
        self.currentUserIsSignedIn = currentUserIsSignedIn
    }
    
    func signUpButtonPressed() {
        guard !textFieldText.isEmpty else { return }
        currentUserIsSignedIn = true
    }
}

struct UITestingBootcampView: View {
    @State private var vm: UITestingBootcampViewModel
    
    init(currentUserIsSignedIn: Bool) {
        _vm = State(wrappedValue: UITestingBootcampViewModel(currentUserIsSignedIn: currentUserIsSignedIn))
    }
    
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [Color.blue, Color.black],
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
            .ignoresSafeArea()
            
            ZStack {
                if vm.currentUserIsSignedIn {
                    SignedInHomeView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .trailing))
                }
                if !vm.currentUserIsSignedIn {
                    signupLayer
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.move(edge: .leading))
                }
            }
            
        }
    }
}

extension UITestingBootcampView {
    private var signupLayer: some View {
        VStack {
            TextField(vm.placeholderText, text: $vm.textFieldText)
                .font(.headline)
                .padding()
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .accessibilityIdentifier("SignUpTextField")
            
            Button {
                withAnimation(.spring) {
                    vm.signUpButtonPressed()
                }
            } label: {
                Text("Sign Up")
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(Color.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .accessibilityIdentifier("SignUpButton")

        }
        .padding()
    }
}

struct SignedInHomeView: View {
    @State var showAlert: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Button(action: {
                    showAlert.toggle()
                }, label: {
                    Text("Show welcome Alert!")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.red)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                })
                .accessibilityIdentifier("ShowAlertButton")
                .alert("Welcome to the app", isPresented: $showAlert) {
                    Text("OK")
                }
                
                NavigationLink {
                    Text("Destination")
                } label: {
                    Text("Navigate")
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(Color.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
                .accessibilityIdentifier("NavigationLinkToDestination")

            }
            .padding()
            .navigationTitle("Welcome")
        }
    }
}

#Preview {
    UITestingBootcampView(currentUserIsSignedIn: false)
}
