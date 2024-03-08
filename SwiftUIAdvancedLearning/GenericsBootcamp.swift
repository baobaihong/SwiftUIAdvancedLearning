//
//  GenericsBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/8.
//

import SwiftUI

struct StringModel {
    let info: String?
    
    func removeInfo() -> StringModel {
        StringModel(info: nil)
    }
}

// to make this whole structure effective to a new model, you can create a new model, but apparently this is not scaleable and hard to maintain
struct BoolModel {
    let info: Bool?
    
    func removeInfo() -> BoolModel {
        BoolModel(info: nil)
    }
}

// use Generic model, you can create a new instance together with a declared type, and use .removeInfo with any type you want
struct GenericModel<T> { // T = Type
    let info: T?
    func removeInfo() -> GenericModel {
        GenericModel(info: nil)
    }
}

@Observable
class GenericsViewModel {
    var stringModel = StringModel(info: "hello world")
    var boolModel = BoolModel(info: true)
    // create generic instances
    var genericStringModel = GenericModel(info: "hello world")
    var genericBoolModel = GenericModel(info: true)
    
    func removeData() {
        stringModel = stringModel.removeInfo()
        boolModel = boolModel.removeInfo()
        genericStringModel = genericStringModel.removeInfo()
        genericBoolModel = genericBoolModel.removeInfo()
    }
}

struct GenericView<T: View>: View {
    let content: T // To put the content in the body, T have to conform to View protocol
    let title: String
    
    var body: some View {
        VStack {
            Text(title)
            content
        }
    }
}

struct GenericsBootcamp: View {
    @State private var vm = GenericsViewModel()
    
    var body: some View {
        VStack(spacing: 20.0) {
            GenericView(content: Text("custom content"), title: "new view")
            // GenericView(title: "new view")
            
            Text(vm.stringModel.info ?? "no data")
            Text(vm.boolModel.info?.description ?? "no data")
            Text(vm.genericStringModel.info ?? "no data")
            Text(vm.genericBoolModel.info?.description ?? "no data")
        }
        .onTapGesture { vm.removeData() }
    }
}

#Preview {
    GenericsBootcamp()
}
