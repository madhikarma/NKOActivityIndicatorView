// swift-tools-version:5.3

import PackageDescription

let package = Package(
	name: "NKOActivityIndicatorView",
	platforms: [
        .iOS(.v14)
    ],
    products: [
        .library(name: "NKOActivityIndicatorView",
            targets: ["NKOActivityIndicatorView"]),
    ],
	targets: [
        .target(
           name: "NKOActivityIndicatorView",
           path: "NKOActivityIndicatorView"), 
)
