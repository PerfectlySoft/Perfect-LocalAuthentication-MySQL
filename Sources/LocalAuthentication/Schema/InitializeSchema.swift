//
//  InitializeSchema.swift
//  Perfect-OAuth2-Server
//
//  Created by Jonathan Guthrie on 2017-02-06.
//
//
import PerfectLib
import StORM
import MySQLStORM
import JSONConfig
import PerfectSessionMySQL

public func initializeSchema(_ fname: String = "./config/ApplicationConfiguration.json") -> [String:Any] {
	var opts = [String:Any]()
	if let config = JSONConfig(name: fname) {
		let dict = config.getValues()!
		opts["httpPort"] = dict["httpport"] as! Int
		// StORM Connector Config
		MySQLConnector.host        = dict["postgreshost"] as? String ?? ""
		MySQLConnector.username    = dict["postgresuser"] as? String ?? ""
		MySQLConnector.password    = dict["postgrespwd"] as? String ?? ""
		MySQLConnector.database    = dict["postgresdbname"] as? String ?? ""
		MySQLConnector.port        = dict["postgresport"] as? Int ?? 0

		// Outbound email config
		SMTPConfig.mailserver         = dict["mailserver"] as? String ?? ""
		SMTPConfig.mailuser			  = dict["mailuser"] as? String ?? ""
		SMTPConfig.mailpass			  = dict["mailpass"] as? String ?? ""
		SMTPConfig.mailfromaddress    = dict["mailfromaddress"] as? String ?? ""
		SMTPConfig.mailfromname        = dict["mailfromname"] as? String ?? ""

		opts["baseURL"] = dict["baseURL"] as? String ?? ""
		AuthenticationVariables.baseURL = dict["baseURL"] as? String ?? ""

		// session driver config
		MySQLSessionConnector.host = MySQLConnector.host
		MySQLSessionConnector.port = MySQLConnector.port
		MySQLSessionConnector.username = MySQLConnector.username
		MySQLSessionConnector.password = MySQLConnector.password
		MySQLSessionConnector.database = MySQLConnector.database
		MySQLSessionConnector.table = "sessions"

	} else {
		print("Unable to get Configuration")

		MySQLConnector.host        = "localhost"
		MySQLConnector.username    = "perfect"
		MySQLConnector.password    = "perfect"
		MySQLConnector.database    = "perfect_testing"
		MySQLConnector.port        = 5432
		
	}

//	StORMdebug = true

	// Account
	let a = Account()
	try? a.setup()

	// Application
	let app = Application()
	try? app.setup()

	// Access Token
	let at = AccessToken()
	try? at.setup()


	return opts
}
