import PackageDescription

let package = Package(
    name: "Perfect-LocalAuthentication-MySQL",
    targets: [
		Target(
			name: "PerfectLocalAuthentication",
			dependencies: []
		)
		],
    dependencies: [
		.Package(url: "https://github.com/iamjono/JSONConfig.git", majorVersion: 3),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-RequestLogger.git", majorVersion: 3),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-SMTP.git", majorVersion: 3),
		.Package(url: "https://github.com/SwiftORM/MySQL-StORM.git", majorVersion: 3),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Session-MySQL.git", majorVersion: 3),
		.Package(url: "https://github.com/PerfectlySoft/Perfect-Mustache.git", majorVersion: 3),
    	.Package(url: "https://github.com/PerfectlySoft/Perfect-HTTP.git", majorVersion: 3)
	]
)
