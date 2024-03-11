//
//  CustomNavBarView.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/9.
//

import SwiftUI

struct CustomNavBarView: View {
    @Environment(\.dismiss) var dismiss
    let showBackButton: Bool
    let title: String
    let subtitle: String?
    
    var body: some View {
        HStack {
            if showBackButton {
                backButton
            }
            Spacer()
            titleSection
            Spacer()
            if showBackButton {
                backButton // <- to push the title to the center
                    .opacity(0)
            }
        }
        .padding()
        .tint(.white)
        .foregroundStyle(.white)
        .font(.headline)
        .background(Color.blue)
    }
}

extension CustomNavBarView {
    private var backButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left")
        }
    }
    
    private var titleSection: some View {
        VStack(spacing: 4.0) {
            Text(title).font(.title).fontWeight(.semibold)
            if let subtitle = subtitle {
                Text(subtitle)
            }
        }
    }
}

#Preview {
    VStack {
        CustomNavBarView(showBackButton: true, title: "title here", subtitle: "subtitle goes here")
        Spacer()
    }
}
