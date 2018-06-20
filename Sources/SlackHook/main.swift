import Foundation

do {
    try CommandLineTool().run()
} catch {
    print("An error occurred: \(error)")
    exit(1)
}
