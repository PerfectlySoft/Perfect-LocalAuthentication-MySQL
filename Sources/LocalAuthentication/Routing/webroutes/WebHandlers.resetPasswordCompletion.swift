//
//  WebHandlers.registerCompletion.swift
//  Perfect-OAuth2-Server
//
//  Created by Fatih Nayebi on 2017-08-08.
//
//

import PerfectHTTP
import PerfectSession
import PerfectCrypto
import PerfectSessionMySQL


extension LocalAuthWebHandlers {
    
    /// resetCompletion
    public static func resetPasswordCompletion(data: [String: Any]) throws -> RequestHandler {
        return {
            request, response in
            let t = request.session?.data["csrf"] as? String ?? ""
            if let i = request.session?.userid, !i.isEmpty { response.redirect(path: "/") }
            var context: [String : Any] = ["title": "Perfect Authentication Server"]
            
            if let r = request.param(name: "passreset"), !(r as String).isEmpty {
                
                let acc = Account(reset: r)
                if acc.id.isEmpty {
                    context["msg_title"] = "Password Reset Error."
                    context["msg_body"] = ""
                    response.render(template: "views/msg", context: context)
                    return
                } else {
                    
                    if let p1 = request.param(name: "p1"), !(p1 as String).isEmpty,
                        let p2 = request.param(name: "p2"), !(p2 as String).isEmpty,
                        p1 == p2 {
                        acc.makePassword(p1)
                        acc.usertype = .standard
                        do {
                            try acc.save()
                            request.session?.userid = acc.id
                            context["msg_title"] = "Password reset was successful."
                            context["msg_body"] = "<p><a class=\"button\" href=\"/\">Click to continue</a></p>"
                            response.render(template: "views/msg", context: context)
                            
                        } catch {
                            print(error)
                        }
                    } else {
                        context["msg_body"] = "<p>Password Reset Error: The passwords must not be empty, and must match.</p>"
                        context["passreset"] = r
                        context["csrfToken"] = t
                        response.render(template: "views/resetPasswordComplete", context: context)
                        return
                    }
                }
            } else {
                context["msg_title"] = "Password Reset Error."
                context["msg_body"] = "Code not found."
                response.render(template: "views/msg", context: context)
            }
        }
    }
}
