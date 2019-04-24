// swift-tools-version:4.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PerfectLocalAuthentication",
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "PerfectLocalAuthentication",
            targets: ["PerfectLocalAuthentication"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
		.package(url: "https://github.com/iamjono/JSONConfig.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-RequestLogger.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-SMTP.git", from: "3.0.0"),
		.package(url: "https://github.com/SwiftORM/MySQL-StORM.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-Session-MySQL.git", from: "3.0.0"),
		.package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", from: "3.0.0"),
    	.package(url: "https://github.com/PerfectlySoft/Perfect-HTTP.git", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "PerfectLocalAuthentication",
            dependencies: ["JSONConfig", "PerfectRequestLogger", "PerfectSMTP", "MySQLStORM", "PerfectSessionMySQL", "PerfectMustache", "PerfectHTTP"]),
        .testTarget(
            name: "PerfectLocalAuthenticationTests",
            dependencies: ["PerfectLocalAuthentication"]),
    ]
)
