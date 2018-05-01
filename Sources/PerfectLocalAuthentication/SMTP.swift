//
//  SMTP.swift
//  Perfect-OAuth2-Server
//
//  Created by Jonathan Guthrie on 2017-02-07.
//
//

import PerfectSMTP

public struct SMTPConfig {
	public static var mailserver = ""
	public static var mailuser = ""
	public static var mailpass = ""
	
	public static var mailfromname = ""
	public static var mailfromaddress = ""
}

public class Utility {
	
	public static func sendMail(name: String = "",
								address: String,
								subject: String,
								html: String = "",
								text: String = "",
								completion: ((Int?, String?, String?) -> Void)? = nil) {
		
		if html.isEmpty && text.isEmpty {
			if let handler = completion {
				handler(nil, nil, nil)
			}
			return
		}
		
		let client = SMTPClient(url: SMTPConfig.mailserver, username: SMTPConfig.mailuser, password: SMTPConfig.mailpass)
		
		let email = EMail(client: client)
		email.subject = subject
		
		// set the sender info
		email.from = Recipient(name: SMTPConfig.mailfromname, address: SMTPConfig.mailfromaddress)
		if !html.isEmpty { email.content = html }
		if !text.isEmpty { email.text = text }
		email.to.append(Recipient(name: name, address: address))
		
		do {
			try email.send { code, header, body in
				/// response info from mail server
				if let handler = completion {
					handler(code, header, body)
				}
			}
		} catch {
			print("sendMail error: \(error)")
			/// something wrong
			if let handler = completion {
				handler(nil, nil, nil)
			}
		}
	}
}
