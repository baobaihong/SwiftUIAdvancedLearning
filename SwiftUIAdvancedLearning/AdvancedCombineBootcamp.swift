//
//  AdvancedCombineBootcamp.swift
//  SwiftUIAdvancedLearning
//
//  Created by Jason on 2024/3/13.
//

import SwiftUI
import Combine

class AdvancedCombineDataService {
    
    //@Published var basicPublisher: String = "first publish"
    //let currentValuePublisher = CurrentValueSubject<String, Error>("first publish")
    let passThroughPublisher = PassthroughSubject<Int, Error>() // <- passthrough subject do not hold the current value, it gets the value and publish it without holding
    let boolPublisher = PassthroughSubject<Bool, Error>()
    let intPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        publishFakeData()
    }
    
    private func publishFakeData() {
        let items: [Int] = Array(1..<11)
        for x in items.indices {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(x), execute: DispatchWorkItem(block: {
                self.passThroughPublisher.send(items[x])
                
                if (x > 4 && x < 8) {
                    self.boolPublisher.send(true)
                    self.intPublisher.send(999)
                } else {
                    self.boolPublisher.send(false)
                }
                
                if x == items.indices.last {
                    self.passThroughPublisher.send(completion: .finished)
                }
            }))
        }
    }
}

class AdvancedCombineBootcampViewModel: ObservableObject {
    @Published var data: [String] = []
    @Published var dataBools: [Bool] = []
    @Published var error: String = ""
    let dataService = AdvancedCombineDataService()
    var cancellable = Set<AnyCancellable>()
    let multiCastPublisher = PassthroughSubject<Int, Error>()
    
    init() {
        addSubscribers()
    }
    
    private func addSubscribers() {
        //dataService.passThroughPublisher
            // 1. Sequence Operations
            /*
                //.first() // <- get the first value and then stop
                //.first(where: { $0 > 4 }) // <- filter the received value
                //.tryFirst(where: { int in
                //    if int == 3 {
                //        throw URLError(.badServerResponse)
                //    }
                //   return int > 1
                //})
                //.last() // <- need to set the 'complete' signal so that the subscriber knows that it's finished.
                //.last(where: { $0 < 4 })
                //.tryLast(where: { int in
                //    if int == 13 {
                //        throw URLError(.badServerResponse)
                //    }
                //    return int > 1
                //})
                //.dropFirst(3) // <- drop the first value, useful when using CurrentValuePublisher
                //.drop(while: { $0 < 3 })
                //.tryDrop(while: { int in
                //    if int == 1//5 {
                //        throw URLError(.badServerResponse)
                //    }
                //    return int < 6
                //})
                //.prefix(4)
                //.prefix(while: { $0 < 5 })
                //.tryPrefix(while: )
                //.output(at: 5) //<- get the value at the specific position
                //.output(in: 2..<4)
            */
        
            // 2. Mathematic Operations
            /*
            //.max() // <- also need to specify the finish
            //.max(by: { int1, int2 in
            //    return int1 < int2
            //})
            //.tryMax(by: )
            //.min()
            //.min(by: )
            //.tryMin(by: )
             */
        
            // 3. Filter / Reducing Operations
            /*
            //.map(KeyPath<Int, T>)
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return String(int)
            //})
            //.compactMap({ int in // use compactMap to ignore part of the invaild data and continue mapping
            //    if int == 5 {
            //        return nil
            //    }
            //    return "\(int)" // String(int)
            //})
            //.tryCompactMap()
            //.filter({ $0 > 3 && $0 < 7 })
            //.tryFilter()
            //.removeDuplicates() // has to be back to back publish
            //.removeDuplicates(by: { Int1, int2 in
            //    return int1 == int2
            //})
            //.tryRemoveDuplicates(by: )
            //.replaceNil(with: 5) // replace nil value with a value
            //.replaceEmpty(with: 5) // replace empty array with a value
            //.replaceError(with: "Default Value")
            //.scan(0, { existingValue, newValue in // use scan to accumulate all previously-published values into a single value
            //    return existingValue + newValue
            //})
            //.scan(0, { $0 + $1 }) // s shorter way of writing the above
            //.scan(0, +) // a even shorter way
            //.reduce(0, { existingValue, newValue in // receive all received elements and produces an accumulated value when finishes
            //    return existingValue + newValue
            //})
            //.reduce(0, +)
            //.collect() // gather elements into an array and emit after finishes.
            //.allSatisfy({ $0 < 50 }) // determine if all elements in a stream satisfy a criteria you provide
            //.tryAllSatisfy()
            */
        
            //4. Timing Operation
            /*
            //.debounce(for: 1, scheduler: DispatchQueue.main) // usually in search, a certain time of delay
            // if the second value is received before the end of debounce period, the new value will replace old
            //.delay(for: 2, scheduler: DispatchQueue.main)
            //.measureInterval(using: DispatchQueue.main) // primarily for debugging purpose
            //.throttle(for: 5, scheduler: DispatchQueue.main, latest: true) // selectively republish elements during an interval you specify.
            //.retry(3) //recreate its subscription to a failed publisher.
            //.timeout(0.75, scheduler: DispatchQueue.main) // Terminates publishing if publisher exceeds the specified time interval
            */
        
            //5. Multiple Publishers / Subscribers
            /*
            //.combineLatest(dataService.boolPublisher, dataService.intPublisher) // boolPublisher and passThroughPublisher are not simultaneously publish as long as any of the publisher publishes, the following code will trigger
            //.compactMap({ $1 ? "\($0)" : "n/a"})
            //.compactMap({ (int1, bool, int2) in // only run when all three publishers publishe values
            //    if bool {
            //        return "\(int1)"
            //    } else {
            //        return "n/a"
            //    }
            //})
            //.merge(with: dataService.intPublisher) // published values should be of same data type
            // .zip(dataService.boolPublisher, dataService.intPublisher) // only one tule value gets published, all publishers need to emit every time
            //.map({ tuple in
            //    return "\(tuple.0) + \(tuple.1.description) + \(tuple.3)"
            //})
            //.tryMap({ int in
            //    if int == 5 {
            //        throw URLError(.badServerResponse)
            //    }
            //    return int
            //})
            //.catch({ error in // when facing an error, switch to another backup publisher
            //    return self.dataService.intPublisher
            //})
            */
        
        let sharedPublisher = dataService.passThroughPublisher
            .share()
            //.multicast {
            //    PassthroughSubject<Int, Error>()
            //}
            .multicast(subject: multiCastPublisher)
        
        sharedPublisher
            .map({ "\($0)" })
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "error: \(error)"
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.data.append(returnedValue)
            }
            .store(in: &cancellable)
        
        sharedPublisher
            .map({ $0 > 5 ? true : false })
            //.collect(3)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    self.error = "error: \(error)"
                    break
                }
            } receiveValue: { [weak self] returnedValue in
                self?.dataBools.append(returnedValue)
            }
            .store(in: &cancellable)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) { // manually switch on the shared publisher
            sharedPublisher
                .connect()
                .store(in: &self.cancellable)
        }
    }
}

struct AdvancedCombineBootcamp: View {
    
    @StateObject private var vm = AdvancedCombineBootcampViewModel()
    
    var body: some View {
        ScrollView {
            HStack {
                VStack {
                    ForEach(vm.data, id: \.self) {
                        Text($0)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                    
                    if !vm.error.isEmpty {
                        Text(vm.error)
                    }
                }
                VStack {
                    ForEach(vm.dataBools, id: \.self) {
                        Text($0.description)
                            .font(.largeTitle)
                            .fontWeight(.black)
                    }
                }
            }
        }
    }
}

#Preview {
    AdvancedCombineBootcamp()
}
