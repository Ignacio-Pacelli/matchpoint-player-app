//
//  User.swift
//  matchpoint
//
//  Created by Nacho Pacelli on 8/2/21.
//

import Foundation

class MatchpointUser {
    var facebookToken: String?
    var jwtToken: String?
    var loginState: String?
    var playerId: String?
    
    init(facebookToken: String?, jwtToken: String?, loginState: String?, playerId: String?) {
            self.facebookToken = facebookToken
            self.jwtToken = jwtToken
            self.loginState = loginState
            self.playerId = playerId
        }
}
