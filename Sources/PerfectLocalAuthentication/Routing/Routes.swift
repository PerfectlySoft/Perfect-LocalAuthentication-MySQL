//
//  WebHandlers.swift
//  Perfect-OAuth2-Server
//
//  Created by Jonathan Guthrie on 2017-02-06.
//
//

public func mainAuthenticationRoutes() -> [[String: Any]] {

	var routes: [[String: Any]] = [[String: Any]]()

	// WEB
	routes.append(["method":"get", "uri":"/login", "handler":LocalAuthWebHandlers.main])
	routes.append(["method":"post", "uri":"/login", "handler":LocalAuthWebHandlers.login])
	routes.append(["method":"get", "uri":"/logout", "handler":LocalAuthWebHandlers.logout])

	routes.append(["method":"get", "uri":"/register", "handler":LocalAuthWebHandlers.register])
	routes.append(["method":"post", "uri":"/register", "handler":LocalAuthWebHandlers.registerPost])
	routes.append(["method":"get", "uri":"/verifyAccount/{passvalidation}", "handler":LocalAuthWebHandlers.registerVerify])
	routes.append(["method":"post", "uri":"/registrationCompletion", "handler":LocalAuthWebHandlers.registerCompletion])
    
    routes.append(["method":"get", "uri":"/resetPass", "handler":LocalAuthWebHandlers.resetPassword])
    routes.append(["method":"post", "uri":"/resetPass", "handler":LocalAuthWebHandlers.resetPasswordPost])
    routes.append(["method":"get", "uri":"/verifyPassReset/{passreset}", "handler":LocalAuthWebHandlers.resetPasswordVerify])
    routes.append(["method":"post", "uri":"/resetPasswordComplete", "handler":LocalAuthWebHandlers.resetPasswordCompletion])


	/// Loads current session & csrf for headers
	routes.append(["method":"get", "uri":"/api/v1/session", "handler":LocalAuthJSONHandlers.session])
	/// Loads info about current user
	routes.append(["method":"get", "uri":"/api/v1/me", "handler":LocalAuthJSONHandlers.me])
	/// Ends current session
	routes.append(["method":"get", "uri":"/api/v1/logout", "handler":LocalAuthJSONHandlers.logout])
	/// Initiates registration process
	routes.append(["method":"post", "uri":"/api/v1/register", "handler":LocalAuthJSONHandlers.register])
	/// Login post route
	routes.append(["method":"post", "uri":"/api/v1/login", "handler":LocalAuthJSONHandlers.login])
	/// Change Password post route
	routes.append(["method":"post", "uri":"/api/v1/changepassword", "handler":LocalAuthJSONHandlers.changePassword])

	return routes
}
