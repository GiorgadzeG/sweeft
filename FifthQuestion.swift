import SwiftUI

struct ContentView: View {

    @State private var inputString = "[[7,10],[2,4]]"
    @State private var result = 0

    var body: some View {
        VStack {
            TextField("Enter a string", text: $inputString)
                .padding()

            Button("Calculate Rooms") {
                let input = inputString
                    .replacingOccurrences(of: "[", with: "")
                    .replacingOccurrences(of: "]", with: "")
                    .replacingOccurrences(of: " ", with: "")
                    .components(separatedBy: ",")
                    .map { Int($0)! }

                var intervals = [[Int]]()
                for i in stride(from: 0, to: input.count, by: 2) {
                    intervals.append([input[i], input[i + 1]])
                }

                result = minMeetingRooms(intervals)
            }
            .padding()

            Text("Meeting Rooms: \(result)")
                .padding()
        }
    }


    func minMeetingRooms(_ intervals: [[Int]]) -> Int {
        var startTimes = [Int]()
        var endTimes = [Int]()

        for interval in intervals {
            startTimes.append(interval[0])
            endTimes.append(interval[1])
        }

        startTimes.sort()
        endTimes.sort()

        var rooms = 0
        var endPointer = 0

        for i in 0..<startTimes.count {
            if startTimes[i] < endTimes[endPointer] {
                rooms += 1
            } else {
                endPointer += 1
            }
        }

        return rooms
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
