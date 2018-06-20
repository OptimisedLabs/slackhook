import Foundation
import SlackHookCore

do {
    try CommandLineTool().run() { error in
        if let error = error {
            print("Unable to post message, because of error: \(error)")
            exit(1)
        }
        
        exit(0)
    }
} catch {
    print("An initialisation error occurred: \(error)")
    exit(1)
}
RunLoop.main.run()
