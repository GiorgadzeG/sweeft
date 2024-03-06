
import SwiftUI

struct ContentView: View {

    @State private var inputArray = "1,1,1,2,2,3" 
    @State private var inputK = "2"
    @State private var result = ""

    var body: some View {
        VStack {
            TextField("Enter an array of integers", text: $inputArray)
                .padding()

            TextField("Enter an integer k", text: $inputK)
                .padding()

            Button("Calculate Top K Frequent") {
                let nums = inputArray.components(separatedBy: ",").compactMap { Int($0) }
                let k = Int(inputK) ?? 0
                let topKFrequentElements = topKFrequent(nums, k)
                result = topKFrequentElements.map { String($0) }.joined(separator: ", ")
            }
            .padding()

            Text("Top K Frequent: \(result)")
                .padding()
        }
    }

    func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
        var dict = [Int: Int]()
        for num in nums {
            dict[num, default: 0] += 1
        }

        let sorted = dict.sorted { $0.value > $1.value }
        return sorted.prefix(k).map { $0.key }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
