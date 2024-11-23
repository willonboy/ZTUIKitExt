// swift-tools-version:5.5
import PackageDescription

let package = Package(
    name: "ZTUIKitExt",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ZTUIKitExt",
            targets: ["ZTUIKitExt"]),
    ],
    dependencies: [
         .package(url: "https://github.com/willonboy/ZTChain", from: "1.0.4"),
         .package(url: "https://github.com/willonboy/ZTStyle", from: "2.0.0"),
    ],
    targets: [
        .target(
            name: "ZTUIKitExt",
            dependencies: []),
    ],
    swiftLanguageVersions: [.version("5.1")]
)
