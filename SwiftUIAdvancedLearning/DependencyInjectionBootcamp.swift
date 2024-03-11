//
//  DependencyInjectionBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/11.
//

import SwiftUI
import Combine

// Probelms with using singletons:
/*
 1. Singletons are globally accessible, causing serious issues when several tasks using the singleton simultaneously
 2. Can't customize the initializer!
 3. Can't swap out dependencies
 */

// Process of Dependency Injection:
// 1. initialize the data service at the start of the code(App level)
// 2. inject the data service into the view before views are displayed
// 3. the view pass the data service into view model

struct PostsModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

protocol DataServiceProtocol {
    func getData() -> AnyPublisher<[PostsModel], Error>
}

class ProductionDataService: DataServiceProtocol {
    // static let instance = ProductionDataService() // Singleton
    let url: URL
    
    init(url: URL) {
        self.url = url
    }
    
    func getData() -> AnyPublisher<[PostsModel], Error> {
        URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: [PostsModel].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

class MockDataService: DataServiceProtocol {
    let testData: [PostsModel]
    
    init(data: [PostsModel]?) {
        testData = data ?? [
            PostsModel(userId: 1, id: 1, title: "One", body: "one"),
            PostsModel(userId: 2, id: 3, title: "Two", body: "two")
        ]
    }
    
    func getData() -> AnyPublisher<[PostsModel], any Error> {
        Just(testData)
            .tryMap({ $0 })
            .eraseToAnyPublisher()
    }
}

//large apps usually have a lot of dependencies so they create a seperate dependencies class
//class Dependencies {
//    let dataService: DataServiceProtocol
//    
//    init(dataService: DataServiceProtocol) {
//        self.dataService = dataService
//    }
//}

@Observable class DependencyInjectionViewModel {
    var dataArray: [PostsModel] = []
    var cancellables = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
        loadPosts()
    }
    
    private func loadPosts() {
        dataService.getData()
            .sink { _ in
                
            } receiveValue: { [weak self] returnedPosts in
                self?.dataArray = returnedPosts
            }
            .store(in: &cancellables)
    }
}

struct DependencyInjectionBootcamp: View {
    @State private var vm: DependencyInjectionViewModel
    
    init(dataService: DataServiceProtocol) {
        _vm = State(wrappedValue: DependencyInjectionViewModel(dataService: dataService))
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(vm.dataArray) { post in
                    Text(post.title)
                }
            }
        }
    }
}

#Preview {
    // let dataService = ProductionDataService(url: URL(string: "https://jsonplaceholder.typicode.com/posts")!)
    let dataService = MockDataService(data: [
        PostsModel(userId: 1234, id: 1234, title: "test", body: "test")
    ])
    
    return DependencyInjectionBootcamp(dataService: dataService)
}
