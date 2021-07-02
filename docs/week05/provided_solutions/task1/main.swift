//
//  main.swift
//  week05_task_1
//
//

import Foundation

/*
 * Store any and all closures for each command. If you want behaviors that are reusable, you
 * could store these closures as functions and put the names of the functions here instead of
 * the closures themselves.
 */

//functions for login
store(validationFunc:{(data:DataDictionary) in
    /*
     * This validation function is obviously too simple to be effective.
     * Passwords have to be more complicated than required here.
     */
    //user name must exist
    guard let userName = data["user_name"] as! String? else{
        return nil
    }
    
    //password must exist
    guard let password:String = data["password"] as! String? else{
        return nil
    }

    //user name must not be empty
    guard userName != "" else{
        return nil
    }
    //password must be longer than 15 characters
    guard password.count > 15 else{
        return nil
    }
    return data
},
interactionFunc: {(data:DataDictionary) in
    //Guards not needed here. By this point the user name and password can not be nil.
    let userName = data["user_name"]! as! String
    let password = data["password"]! as! String
    //Fake database access here. Pretend the only user is "yenrab" with password "How far the little candle throws his beams! A fool doth think he is wise."
    if userName != "yenrab" || password != "How far the little candle throws his beams! A fool doth think he is wise."{
        return nil
    }
    //I'm faking some data that comes from the database that indicates what this user is allowed to do.
    
    return ["Role":"site_administrator"]
}, responseFunc: {(data:DataDictionary) in
    //I decided that in my application, the responses will always be formatted as JSON.
    //There are a bunch of things you are not required to know for this class in the code below.
    //You might want to know how to convert Swift data structures to JSON anyway.
    do{
        let encodedData = try JSONEncoder().encode(data as! [String:String])
        let jsonString:Any = String(data: encodedData,encoding: .utf8)!
        return ["JSON":jsonString]
    }
    catch{
        return nil
    }
}, for: "login")

//Functions for othere commands would go here.



var result = handleRequest(for: "login", with: ["user_name":"yenrab",
                                   "password":"How far the little candle throws his beams! A fool doth think he is wise."])
print(result)

result = handleRequest(for: "login", with: ["user_name":"bob",
                                   "password":"password"])
print(result)
