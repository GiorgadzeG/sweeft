
import SwiftUI

struct ContentView: View {
    
    @State private var inputString = "ADOBECODEBANC"
    @State private var inputString2 = "ABC"
    @State private var result = ""

    var body: some View {
        VStack {
            TextField("Enter a string", text: $inputString)
                .padding()
            TextField("Enter a string", text: $inputString2)
                .padding()

            Button("Calculate Length") {
                result = minWindow(inputString, inputString2)
            }
            .padding()

            Text("Longest Substring Length: \(result)")
                .padding()
        }
    }

    func minWindow(_ s: String, _ t: String) -> String {
        var result = ""
        var s = Array(s)
        var t = Array(t)
        var tCount = t.count
        var minLen = Int.max
        var left = 0
        var right = 0
        var minStart = 0

        var dict = [Character: Int]()
        for char in t {
            dict[char, default: 0] += 1
        }

        while right < s.count {
            if dict[s[right], default: 0] > 0 {
                tCount -= 1
            }
            dict[s[right], default: 0] -= 1
            right += 1

            while tCount == 0 {
                if right - left < minLen {
                    minLen = right - left
                    minStart = left
                }
                dict[s[left], default: 0] += 1
                if dict[s[left], default: 0] > 0 {
                    tCount += 1
                }
                left += 1
            }
        }

        if minLen != Int.max {
            result = String(s[minStart..<minStart + minLen])
        }

        return result
    }

}

#Preview {
    ContentView()
}
