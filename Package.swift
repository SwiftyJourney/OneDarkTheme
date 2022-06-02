// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "XcodeOneDarkTheme",
  products: [
    .executable(name: "One Dark Theme", targets: ["XcodeOneDarkTheme"])
  ],
  dependencies: [
    .package(url: "https://github.com/JohnSundell/Files.git", from: "4.0.0"),
    .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0")
  ],
  targets: [
    .executableTarget(
      name: "XcodeOneDarkTheme",
      dependencies: ["Files", "ShellOut"])
  ]
)
