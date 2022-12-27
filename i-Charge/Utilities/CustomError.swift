//
//  CustomError.swift
//  i-Charge
//
//  Created by Greg Ross on 27/12/2022.
//

import Foundation


enum CustomError: Error{
    case completionFailed(errorMessage: String)
    
    var message: String{
        switch self{
        case .completionFailed(let message):
            return "The comletion failed. This is the error: \(message)"
        }
    }
}
