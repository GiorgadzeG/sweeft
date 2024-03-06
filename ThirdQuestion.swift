import SwiftUI

struct ContentView: View {
    
    @State private var inputString = "applepenapple"
    @State private var inputWordsString = ""
    @State private var result = false
    @State private var showError = false

    var body: some View {
        VStack {
            TextField("Enter a string", text: $inputString)
                .padding()

            TextField("Enter words separated by comma", text: $inputWordsString)
                .padding()

            Button("Check") {
                let inputWords = inputWordsString.components(separatedBy: ",")
                    .map { $0.trimmingCharacters(in: .whitespaces) }

                if inputWords.isEmpty {
                    showError = true
                } else {
                    result = wordBreak(inputString, inputWords)
                }
            }
            .padding()

            if showError {
                Text("Please enter words separated by comma")
                    .foregroundColor(.red)
                    .padding()
            } else {
                Text("Can be split: \(result ? "true" : "false")")
                    .padding()
            }
        }
    }

    func wordBreak(_ s: String, _ words: [String]) -> Bool {
        var wordSet = Set(words)
        var dp = Array(repeating: false, count: s.count + 1)
        dp[0] = true

        for i in 1...s.count {
            for j in 0..<i {
                if dp[j] && wordSet.contains(String(s[s.index(s.startIndex, offsetBy: j)..<s.index(s.startIndex, offsetBy: i)])) {
                    dp[i] = true
                    break
                }
            }
        }

        return dp[s.count]
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
