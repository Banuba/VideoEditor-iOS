// swift-tools-version:5.9

import PackageDescription

let package = Package(
  name: "VideoEditor",
  platforms: [
    .iOS(.v17)
  ],
  products: [
    .library(
      name: "VideoEditor",
      targets: ["VideoEditor"]
    )
  ],
  targets: [
    .binaryTarget(
      name: "VideoEditor",
      path: "VideoEditor.xcframework"
    )
  ]
)
