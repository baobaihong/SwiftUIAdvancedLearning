//
//  ProtocolsBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/11.
//

import SwiftUI

struct DefaultColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .white
    let tertiary: Color = .gray
}

struct AlternativeColorTheme: ColorThemeProtocol {
    let primary: Color = .red
    let secondary: Color = .white
    let tertiary: Color = .green
}

struct AnotherColorTheme: ColorThemeProtocol {
    let primary: Color = .blue
    let secondary: Color = .black
    let tertiary: Color = .purple
}

protocol ColorThemeProtocol {
    var primary: Color { get } //<- to set a property in protocol, you have to use 'var' and { get } or { get set } to set accessibility
    var secondary: Color { get }
    var tertiary: Color { get }
}

protocol ButtonTextProtocol {
    var buttonText: String { get }
    // func buttonPressed() // functions in protocol do not write the body {}
}

protocol ButtonPressedProtocol {
    func buttonPressed()
}

// protocols can inherit from other protocols
protocol ButtonDataSourceProtocol: ButtonTextProtocol, ButtonPressedProtocol { }

class DefaultDataSource: ButtonDataSourceProtocol {
    var buttonText: String = "Hello world"
    
    func buttonPressed() {
        print("Button was pressed")
    }
}

class AlternativeDataSource: ButtonTextProtocol {
    var buttonText: String = "World hello"
    
    func buttonPressed() {
        print("Button was pressed")
    }
}

struct ProtocolsBootcamp: View {
    // without the protocol if you want to change the color theme, you have to change the type as well
    // with protocol, you can unify the type to protocol
    let colorTheme: ColorThemeProtocol
    let dataSource: ButtonDataSourceProtocol
    
    var body: some View {
        ZStack {
            colorTheme.tertiary.ignoresSafeArea()
            Text(dataSource.buttonText)
                .font(.headline)
                .foregroundStyle(colorTheme.secondary)
                .padding()
                .background(colorTheme.primary)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .onTapGesture {
                    dataSource.buttonPressed()
                }
        }
    }
}

#Preview {
    ProtocolsBootcamp(colorTheme: DefaultColorTheme(), dataSource: DefaultDataSource())
}
