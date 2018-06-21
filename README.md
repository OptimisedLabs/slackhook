# SlackHook [![pipeline status](https://gitlab.com/optimisedlabs/slackhook/badges/master/pipeline.svg)](https://gitlab.com/optimisedlabs/slackhook/commits/master)

[![coverage report](https://gitlab.com/optimisedlabs/slackhook/badges/master/coverage.svg)](https://gitlab.com/optimisedlabs/slackhook/commits/master)
[![codebeat badge](https://codebeat.co/badges/2f9f6122-5d8f-4b51-a098-4d4eda671585)](https://codebeat.co/projects/github-com-optimisedlabs-slackhook-master)
[![Language](https://img.shields.io/badge/language-Swift%204.1-orange.svg)](https://developer.apple.com/swift/)
[![Platforms](https://img.shields.io/badge/platform-ios%20%7C%20macos%20%7C%20tvos%20%7C%20watchos%20%7C%20linux-yellow.svg)](https://gitlab.com/optimisedlabs/simplerestlayer)
[![Swift PM](https://img.shields.io/badge/spm-compatible-brightgreen.svg)](https://swift.org/package-manager)
[![License](https://img.shields.io/badge/license-Apache--2.0-lightgrey.svg)](https://github.com/graemer957/helloworld-swift-framework/blob/master/LICENSE)

Send messages to Slack from Swift.

## Features

- [x] Send simple text only messages
- [x] Add attachements with colours and fields

See [Slack API documentation](https://api.slack.com/docs/messages) for more information.

## Usage

SlackHook should be simple to use and have a self explanatory API.

```swift
import SlackHookCore

let slackHook = try SlackHook(from: "Slack WehHook URL")
let message = Message(text: "Hello from Swift", username: "SlackHook", attachments: nil)
try! slackHook.post(message)
```

## Dependancies

- [Foundation](https://developer.apple.com/documentation/foundation/urlsession)
- [SimpleRESTLayer](https://github.com/graemer957/SimpleRESTLayer)

## Requirements

- Swift 4.1+ / Xcode 9.4.1+
- iOS 10.0+ / macOS 10.12+ / tvOS 10.0+ / watchOS 3.0+
- Ubuntu 14.04 / Ubuntu 16.04 / Ubuntu 16.10

## Installation

### Swift Package Manager

In your `Packages.swift` add:

```swift
.package(url: "https://gitlab.com/optimisedlabs/slackhook.git", .from: "0.2.0")
```

*NOTE*: `.upToNextMinor(from: "0.2.0")` might be better whilst the API stablises.

## Acknowledgements and thanks

Whilst this is by no means an exhaustive list, I would like to thank:
- [Apple](https://developer.apple.com), standing on the shoulders of giants...
- Excellent article on [Building a command line tool using the Swift Package Manager](https://www.swiftbysundell.com/posts/building-a-command-line-tool-using-the-swift-package-manager) by [John Sundell](https://github.com/johnsundell)

## License

SlackHook is released under the Apache 2.0 license. See [LICENSE](LICENSE) for details.
