
import Foundation

var argsIntArray = CommandLine.arguments.compactMap { Int($0) }
let randomIntLimitConst = 50000

let fileName = getDocumentsDirectory().appendingPathComponent("output.txt")

let existingFile = FileManager.default.fileExists(atPath: fileName.absoluteString)

if (!existingFile) {
    if (FileManager.default.createFile(atPath: fileName.absoluteString, contents: nil, attributes: nil)) {
        print("Fisier creat cu succes.")
    } else {
        print("Eroare creare fisier.")
    }
}

writeToFile(text: "\n\t[ QUICKSORT ]\n\n", url: fileName)

for argIntNumber in argsIntArray {
    var array = [Int]()

    for _ in 1 ... argIntNumber {
        let randomInt = Int.random(in: 0 ..< randomIntLimitConst)
        array.append(randomInt)
    }

    // tema laborator 1 CMo
    let localTimeStart = DispatchTime.now()
    let _ = quickSort2(array, left: 0, right: array.count - 1)
    let localTimeEnd = DispatchTime.now()

    // nano secunde (UInt64)
    let localTimeNano = localTimeEnd.uptimeNanoseconds - localTimeStart.uptimeNanoseconds

    // risc overflow
    let timeInterval = Double(localTimeNano) / 1_000_000_000

    let str = "\nDiferenta de rulat de la data: \(getCurrentFormattedDate())\n" +
        "Se scrie in fisierul \"\(fileName)\" in modul [ APPEND ]" +
        " pentru a vedea timpul de executie ...\n" +
        "Timpul de executie pentru un set random de \(argIntNumber) numere: \(timeInterval) secunde\n"

    // print("Afisare array sortat: \(sortedArray)")

    writeToFile(text: str, url: fileName)
}

print("< terminare app >")

func getDocumentsDirectory() -> URL {
    let path = FileManager.default.currentDirectoryPath;

    let url = URL(string: path)

    return url!;
}

func getCurrentFormattedDate() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm:ss"
    let result = formatter.string(from: date)

    return result;
}

func quicksort<T: Comparable>(_ a: [T]) -> [T] {
    guard a.count > 1 else {
        return a
    }

    let pivot = a[a.count / 2]
    
    let less = a.filter { $0 < pivot }
    let equal = a.filter { $0 == pivot }
    let greater = a.filter { $0 > pivot }

    return quicksort(less) + equal + quicksort(greater)
}

func quickSort2(_ input: [Int], left:Int, right: Int)-> [Int] {
    var inputArray = input
    if left < right {
        let pivot = inputArray[right]
        var index = left

        for demo in left..<right {
            if inputArray[demo] <= pivot {
                (inputArray[index], inputArray[demo]) = (inputArray[demo], inputArray[index])
                index += 1
            }
        }
        
        (inputArray[index], inputArray[right]) = (inputArray[right], inputArray[index])
        inputArray = quickSort2(inputArray, left: left, right: index-1)
        inputArray = quickSort2(inputArray, left: index+1, right: right)
    }
    
    return inputArray
}

func writeToFile(text: String, url: URL) {
    if let handle = try? FileHandle(forWritingTo: url) {
        handle.seekToEndOfFile()
        handle.write(text.data(using: .utf8)!)
        handle.closeFile()
    }
}