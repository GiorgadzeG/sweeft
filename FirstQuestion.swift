
import SwiftUI

struct ContentView: View {
    
    @State private var inputString = "abcabcbbdasdasdas"
    @State private var result = 0

    var body: some View {
        VStack {
            TextField("Enter a string", text: $inputString)
                .padding()

            Button("Calculate Length") {
                result = lengthOfLongestSubstring(inputString)
            }
            .padding()

            Text("Longest Substring Length: \(result)")
                .padding()
        }
    }

    func lengthOfLongestSubstring(_ s: String) -> Int {
        var maxLength = 0
        var currentLength = 0
        var lastSeen = [Character: Int]()

        for (i, char) in s.enumerated() {
            if let prevIndex = lastSeen[char] {
                currentLength = min(i - prevIndex, currentLength + 1)
            } else {
                currentLength += 1
            }

            lastSeen[char] = i
            maxLength = max(maxLength, currentLength)
        }

        return maxLength
    }

}

#Preview {
    ContentView()
}
