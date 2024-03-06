
/*****  

    Მოცემულია String ტიპის ცვლადი “s”. იპოვეთ ყველაზე გრძელი ისეთი substring-ის ზომა,
    რომელშიც ყველა სიმბოლო უნიკალურია(არ მეორდება).   

*******/ 

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


/***  

    Მოცემულია ორი String ცვლადი “s” და “t” დააბრუნეთ მინიმალური ფანჯარა(უწყვეტი
    საბსტრინგი) “s”-დან რომელიც შეიცავს “t”-ში შემავალ ყველა სიმბოლოს. თუ “s”-ში არ არის
    ისეთი ფანჯარა, რომელიც მოიცავს “t”-ის ყველა სიმბოლოს, დააბრუნეთ ცარიელი
    სტრინგი("").  

***/ 


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


/***  

    Მოცემულია String “s” და String-ების მასივი “words”. დააბრუნეთ “true” თუ შეიძლება
    “s”-ის დაყოფა “-”-ით დაშორებული სიტყვების მიმდევრობად “words”-დან.

***/

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


/***  

    Მოცემულია მთელი რიცხვების მასივი “nums” და მთელი რიცხვი “k”. დააბრუნეთ
    დააბრუნეთ ყველაზე ხშირად გამეორებული “k” ცალი ელემენტი. Პასუხი შეგგიძლიათ
    დააბრუნოთ ნებისმიერი თანმიმდევრობით.

***/

func topKFrequent(_ nums: [Int], _ k: Int) -> [Int] {
    var dict = [Int: Int]()
    for num in nums {
        dict[num, default: 0] += 1
    }

    let sorted = dict.sorted { $0.value > $1.value }
    return sorted.prefix(k).map { $0.key }
}


/***  

    Მოცემულია შეხვედრების დროით ინტერვალების ორგანზომილებიანი მასივების მასივი
    “intervals”, სადაც “intervals[i] = [start_i, end_i]”. დააბრუნეთ მინიმუმ რამდენი ოთახია
    საჭირო ყველა შეხვედრის ჩასატარებლად(ისეთი შეხვედრები რომელთა ჩატარების
    დროებში თანაკვეთაა ერთ ოთახში ვერ ჩატარდება).

***/

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