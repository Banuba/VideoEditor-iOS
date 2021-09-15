// swift-tools-version:5.3
import PackageDescription
let package = Package(
  name: "VideoEditor",
  platforms: [
    .iOS(.v11)
  ],
  products: [
    .library(
      name: "VideoEditor",
      targets: ["VideoEditor"])
  ],
  targets: [
    .binaryTarget(
      name: "VideoEditor",
      path: "VideoEditor.xcframework")
  ])
