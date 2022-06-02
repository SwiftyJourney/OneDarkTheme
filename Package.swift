// swift-tools-version: 5.6

import PackageDescription

let package = Package(
  name: "XcodeOneDarkTheme",
  dependencies: [
    .package(url: "https://github.com/JohnSundell/Files.git", from: "4.0.0"),
    .package(url: "https://github.com/JohnSundell/ShellOut.git", from: "2.0.0")
  ],
  targets: [
    .target(
      name: "XcodeOneDarkTheme",
      dependencies: ["Files", "ShellOut"])
  ]
)
