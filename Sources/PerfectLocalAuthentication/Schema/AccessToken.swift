//
//  AccessToken.swift
//  Perfect-OAuth2-Server
//
//  Created by Jonathan Guthrie on 2017-02-06.
//
//

import StORM
import MySQLStORM
import Foundation

public class AccessToken: MySQLStORM {
	public var accesstoken		= ""
	public var refreshtoken		= ""
	public var userid			= ""
	public var clientid			= ""
	public var expires			= 0
	public var scope			= ""

	public static func generate() -> String {
		if let a = Array<UInt8>(randomCount: 16).encode(.base64),
			let b = String(bytes: a, encoding: .utf8) {
			return b.replacingOccurrences(of: "=", with: "")
			.replacingOccurrences(of: "+", with: "-")
			.replacingOccurrences(of: "/", with: "_")
		} else {
			return ""
		}
	}


	public static func setup(_ str: String = "") {
		do {
			let obj = AccessToken()
			try obj.setup(str)

			// Migrations
			let _ = try obj.sql("ALTER TABLE accesstoken ADD COLUMN `clientid` text", params: [])

		} catch {
			// nothing
		}
	}


	public override init(){}

	public init(userid u: String, clientid c: String = "", expiration: Int, scope s: [String] = [String]()) {
		accesstoken = AccessToken.generate()
		refreshtoken = AccessToken.generate()
		clientid = c
		userid = u
		expires = time(nil) + expiration
		scope = s.isEmpty ? "" : s.joined(separator: " ")
	}


	override public func to(_ this: StORMRow) {
		accesstoken     = this.data["accesstoken"] as? String	?? ""
		refreshtoken	= this.data["refreshtoken"] as? String	?? ""
		userid			= this.data["userid"] as? String		?? ""
		clientid		= this.data["clientid"] as? String		?? ""
		expires			= this.data["expires"] as? Int			?? 0
		scope			= this.data["scope"] as? String			?? ""
	}

	public func rows() -> [AccessToken] {
		var rows = [AccessToken]()
		for i in 0..<self.results.rows.count {
			let row = AccessToken()
			row.to(self.results.rows[i])
			rows.append(row)
		}
		return rows
	}

	public func isCurrent() -> Bool {
		if time(nil) > expires { return false }
		return true
	}

}
