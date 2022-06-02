//
//  Created by Juan Francisco Dorado Torres on 01/06/22.
//

import Foundation
import Files
import ShellOut

let fontsFolder = try Folder.home.subfolder(at: "Library/Fonts")

if !fontsFolder.containsFile(named: "FiraCode-Medium.ttf") || !fontsFolder.containsFile(named: "FiraCode-Retina.ttf") {
  print("⏬ Downloading Fira Code font...")

  let fontZipURL = URL(string: "https://github.com/tonsky/FiraCode/releases/download/6.2/Fira_Code_v6.2.zip")!
  let fontZipData = try Data(contentsOf: fontZipURL)

  print("🔧 Installing Fira Code font...")

  let fontZipFile = try fontsFolder.createFile(named: "FiraCode.zip", contents: fontZipData)
  try shellOut(to: "unzip \(fontZipFile.name) -d FiraCode", at: fontsFolder.path)

  let firaCodeFolder = try fontsFolder.subfolder(named: "FiraCode")
  let ttfFolder = try firaCodeFolder.subfolder(named: "ttf")
  ttfFolder.files.forEach({ file in
    do {
      try file.move(to: fontsFolder)
    } catch {
      let locationError = error as! LocationError
      let reason = locationError.reason
      switch reason {
      case .moveFailed(let error):
        print("⚠️ \(error.localizedDescription)")
      default:
        print("😨 Oh oh, something more went wrong!")
      }
    }
  })

  try firaCodeFolder.delete()
  try fontZipFile.delete()
}

print("🎨 Installing One Dark Theme for Xcode...")

let themeURL = URL(fileURLWithPath: #file.replacingOccurrences(of: "Sources/XcodeTheme/main.swift", with: "One Dark.xccolortheme"))
let themeData = try Data(contentsOf: themeURL)

let xcodeFolder = try Folder.home.subfolder(at: "Library/Developer/Xcode")
let userDataFolder = try xcodeFolder.createSubfolderIfNeeded(withName: "UserData")
let themeFolder = try userDataFolder.createSubfolderIfNeeded(withName: "FontAndColorThemes")

let themeFile = try themeFolder.createFileIfNeeded(withName: "One Dark.xccolortheme")
try themeFile.write(themeData)

print("")
print("🎉 One Dark Theme successfully installed")
print("👍 Select it in Xcode's preferences to start using it (you may have to restart Xcode first)")
