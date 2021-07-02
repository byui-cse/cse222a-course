//
//  app_controller.swift
//  week05_task_1
//
//

import Foundation

//a series of typedefs to ease code clarity
typealias DataDictionary = Dictionary<String,Any>
typealias CommandDictionary = Dictionary<String,(DataDictionary)->DataDictionary?>
typealias RequestFunc = (DataDictionary)->DataDictionary?

/// A series of values used by the handleRequest function to communicate success and errors.
enum RequestMessage {
    case success
    case failedValidation
    case failedInteraction
    case failedResponse
    case noSuchCommand
}

private var validationFunctions = CommandDictionary()
private var interactionFunctions = CommandDictionary()
private var responseFunctions = CommandDictionary()


/// This function executes a specified set of behaviors for a given command.
///
/// The behaviors executed are those stored in the store method of this module.
/// The order of execution is 1)validation, 2)interaction, 3)response. If any
/// of the stored functions returns nil, this function returns without executing any
/// of the other stored functions with an appropriate error indicated in the returned value.
/// See the RequestMessage struct for all possible messages.
///
/// - Parameters:
///   - command: a unique indicator of which set of behaviors to execute
///   - data: any data required to act on the command
/// - Returns: (RequestMessage.success,\[String:Any\]) when all functions work without error. (RequestMessage,[\String:Any\]) otherwise.
/// - Complexity: O(1) plus the complexity of each of the validation, interaction, and response functions
func handleRequest(for command:String, with data:DataDictionary)->(Bool,RequestMessage,DataDictionary?){
    //if all three functions exist the command is an expected command
        guard let aValidationFunction = validationFunctions[command],
              let anInteractionFunction = interactionFunctions[command],
              let aResponseFunction = responseFunctions[command]
        else {
            return (false,.noSuchCommand, data)
        }
        // if successfully found functions, do what ever validation is needed
        guard let theValidationData = aValidationFunction(data)  else {
            return (false,.failedValidation,data)
        }
        //if successfully validated, do what ever interaction is needed
        guard let theInteractionData = anInteractionFunction(theValidationData)
        else {
            return (false,.failedInteraction,theValidationData)
        }
        //if successfully completed interaction, put together a response
        guard let theResponseData = aResponseFunction(theInteractionData)
        else {
            return (false,.failedResponse,theInteractionData)
        }
    return (true,.success,theResponseData)
}

/// This function stores a set of RequestFuncs for later execution.
///
/// Each time the command and a DataDictionary is passed to handleRequest, the functions stored by this
/// function are executed.
///
/// - Parameters:
///   - validationFunc: a function used to ensure the incoming data meets requirements and is verified as 'safe'
///   - interactionFunc: a function used to do any required business logic
///   - responseFunc: a function to generate a response using the result of the interactionFunc
///   - command: a unique indicator for this set of behaviors
func store(validationFunc:@escaping RequestFunc,
           interactionFunc:@escaping RequestFunc,
           responseFunc:@escaping RequestFunc,
           for command:String){
    validationFunctions[command] = validationFunc
    interactionFunctions[command] = interactionFunc
    responseFunctions[command] = responseFunc
}
