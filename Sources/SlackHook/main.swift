let tool = CommandLineTool()

do {
    try tool.run()
} catch {
    print("An error occurred: \(error)")
}
