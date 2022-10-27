import Foundation

var argsIntArray = CommandLine.arguments.compactMap { Int($0) }
let randomIntLimitConst = 50000

let fileName = getDocumentsDirectory().appendingPathComponent("output2.txt")

let existingFile = FileManager.default.fileExists(atPath: fileName.absoluteString)

if (!existingFile) {
    if (FileManager.default.createFile(atPath: fileName.absoluteString, contents: nil, attributes: nil)) {
        print("Fisier creat cu succes.")
    } else {
        print("Eroare creare fisier.")
    }
}

writeToFile(text: "\n\t[ BUBBLESORT ]\n\n", url: fileName)

for argIntNumber in argsIntArray {
    var array = [Int]()

    for _ in 1 ... argIntNumber {
        let randomInt = Int.random(in: 0 ..< randomIntLimitConst)
        array.append(randomInt)
    }

    // tema laborator 1 CMo
    let localTimeStart = DispatchTime.now()
    bubbleSort(a: &array)
    let localTimeEnd = DispatchTime.now()

    // nano secunde (UInt64)
    let localTimeNano = localTimeEnd.uptimeNanoseconds - localTimeStart.uptimeNanoseconds

    // risc overflow
    let timeInterval = Double(localTimeNano) / 1_000_000_000

    let str = "\nDiferenta de rulat de la data: \(getCurrentFormattedDate())\n" +
        "Se scrie in fisierul \"\(fileName)\" in modul [ APPEND ]" +
        " pentru a vedea timpul de executie ...\n" +
        "Timpul de executie pentru un set random de \(argIntNumber) numere: \(timeInterval) secunde\n"

    writeToFile(text: str, url: fileName)

    // print("Afisare array sortat: \(array)")
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

func bubbleSort(a: inout [Int]) {
    let n = a.count

    for i in 0 ..< n - 1 {
        for j in 0 ..< n - i - 1 {
            if a[j] > a[j + 1] {
                let temp = a[j]
                a[j] = a[j + 1]
                a[j + 1] = temp
            }
        }
    }
}

func writeToFile(text: String, url: URL) {
    if let handle = try? FileHandle(forWritingTo: url) {
        handle.seekToEndOfFile()
        handle.write(text.data(using: .utf8)!)
        handle.closeFile()
    }
}