//
//  WebHandlers.logout.swift
//  Perfect-OAuth2-Server
//
//  Created by Jonathan Guthrie on 2017-04-26.
//
//

import PerfectHTTP
import PerfectSession
import PerfectCrypto
import PerfectSessionMySQL


extension LocalAuthWebHandlers {

	public static func logout(data: [String:Any]) throws -> RequestHandler {
		return {
			request, response in
			if let _ = request.session?.token {
				MySQLSessions().destroy(request, response)
				request.session = PerfectSession()
				response.request.session = PerfectSession()
			}
			response.redirect(path: "/")
		}
	}


}
