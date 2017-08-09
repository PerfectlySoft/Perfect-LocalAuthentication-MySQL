//
//  WebHandlers.resetPassword.swift
//  LocalAuthentication
//
//  Created by Fatih Nayebi on 2017-08-08.
//
//

import PerfectHTTP
import PerfectSession
import PerfectCrypto
import PerfectSessionMySQL

extension LocalAuthWebHandlers {
    
    // Reset Password GET - displays form
    public static func resetPassword(data: [String: Any]) throws -> RequestHandler {
        return {
            request, response in
            if let i = request.session?.userid, !i.isEmpty { response.redirect(path: "/") }
            let t = request.session?.data["csrf"] as? String ?? ""
            
            var context: [String: Any] = ["title": "Perfect Authentication Server"]
            context["csrfToken"] = t
            response.render(template: "views/resetPassword", context: context)
        }
    }
    
    
    // POST request for register form
    public static func resetPasswordPost(data: [String: Any]) throws -> RequestHandler {
        return {
            request, response in
            if let i = request.session?.userid, !i.isEmpty { response.redirect(path: "/") }
            var context: [String: Any] = ["title": "Perfect Authentication Server"]
            
            if let e = request.param(name: "email"), !(e as String).isEmpty {
                let err = Account.resetPassword(e, baseURL: AuthenticationVariables.baseURL)
                if err != .noError {
                    print(err)
                    context["msg_title"] = "Password Reset Error."
                    context["msg_body"] = "\(err)"
                } else {
                    context["msg_title"] = "You are resetting your password."
                    context["msg_body"] = "Check your email for an email from us. It contains instructions to reset your password!"
                }
            } else {
                
            }
            response.render(template: "views/msg", context: context)
        }
    }
}
