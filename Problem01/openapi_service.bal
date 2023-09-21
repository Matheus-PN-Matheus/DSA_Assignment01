// AUTO-GENERATED FILE.
// This file is auto-generated by the Ballerina OpenAPI tool.

//***THIS 2023 DSA612S ASSIGNMENT WAS DONE BY***
//--1. A-Jay Steyn -- 222082429
//--2. Denver January -- 216013216
//--3. Matheus PN Matheus -- 220075921
//--4. Mushe Mulauli -- 221094296

import ballerina/http;

// The service listens on port 9090 and provides various endpoints related to our lecturers.
// Each resource function in the service corresponds to an API endpoint.

listener http:Listener ep0 = new (9090, config = {host: "localhost"});

//we will explain our assignment describing service-side and client-side interractions

service / on ep0 {
    # Retrieve a list of all lecturers within the faculty
    # + return - A list of lecturers 
    
    
    // This endpoint retrieves all lecturers.
    // Service-side: This endpoint responds to the GET request sent by the client's `get lecturers` method.
    resource function get lecturers() returns Lecturer[] {
        return lecturersTable.toArray();
    }
    # Add a new lecturer
    #
    # + payload - parameter description 
    # + return - returns can be any of following types
    # http:Created (Lecturer added successfully)
    # http:BadRequest (Invalid input)
    
    
    //ADD new lecturer
    // This endpoint adds a new lecturer.
    // Service-side: This endpoint responds to the POST request sent by the client's `post lecturers` method.
    resource function post lecturers(@http:Payload Lecturer new_Lecturer) returns http:Created|http:BadRequest {
        
    // Check if the lecturer with the given staffNumber already exists
    if (lecturersTable.hasKey(new_Lecturer.staffNumber)) {
        return http:BAD_REQUEST;
    }
    
    // Add the new lecturer to the table
    lecturersTable.add(new_Lecturer);

    // Return a Created response
    return http:CREATED;
    }

# Retrieve the details of a specific lecturer by their staff number
    #
    # + staffNumber - Unique staff number of the lecturer 
    # + return - returns can be any of following types
    # Lecturer (Details of the lecturer)
    # http:NotFound (Lecturer not found)
    

    // This endpoint retrieves the details of a specific lecturer based on their staff number.
    // Service-side: This endpoint responds to the GET request sent by the client's `get lecturers/[string staffNumber]` method.
    resource function get lecturers/[string staffNumber]() returns Lecturer|http:NotFound {
<<<<<<< HEAD

        Lecturer? queriedLecturer = lecturersTable[staffNumber];
        if (queriedLecturer is ()) {
            return http:NOT_FOUND;
        } else {
            return queriedLecturer;
        }
    }
=======
>>>>>>> 2ba0ce9707241bf22c30464344ef4be76c556cf9

        Lecturer? queriedLecturer = lecturersTable[staffNumber];
        if (queriedLecturer is ()) {
            return http:NOT_FOUND;
        } else {
            return queriedLecturer;
        }
    }
    
    //The Following code was submitted bt Denver January -- 216013216
    # Update an existing lecturer's information
    #
    # + staffNumber - Unique staff number of the lecturer 
    # + payload - parameter description 
    # + return - returns can be any of following types
    # http:Ok (Lecturer updated successfully)
    # http:BadRequest (Invalid input)
    # http:NotFound (Lecturer not found)
    
    // This endpoint updates an existing lecturer's details.
    // Service-side: This endpoint responds to the PUT request sent by the client's `put lecturers/[string staffNumber]` method.
    resource function put lecturers/[string staffNumber](@http:Payload Lecturer updatedLecturer) returns http:Response {
         // First, check if the lecturer with the given staffNumber exists
    // First, check if the lecturer with the given staffNumber exists
    if (!lecturersTable.hasKey(staffNumber)) {
        http:Response notFoundResponse = new;
        notFoundResponse.statusCode = http:STATUS_NOT_FOUND;
        notFoundResponse.setPayload("Lecturer not found");
        return notFoundResponse;
    }

    // Remove the existing lecturer details from the lecturersTable
    _ = lecturersTable.remove(staffNumber);

    // Add the updated lecturer details to the lecturersTable
    lecturersTable.add(updatedLecturer);

    http:Response successResponse = new;
    successResponse.statusCode = http:STATUS_OK;
    successResponse.setPayload("Lecturer updated successfully");
    return successResponse;
        }

    
    


    # Delete a lecturer's record by their staff number
    #
    # + staffNumber - Unique staff number of the lecturer 
    # + return - returns can be any of following types
    # http:NoContent (Lecturer deleted successfully)
    # http:NotFound (Lecturer not found)
    

    // This endpoint deletes a lecturer based on their staff number.
    // Service-side: This endpoint responds to the DELETE request sent by the client's `delete lecturers/[string staffNumber]` method.
    resource function delete lecturers/[string staffNumber]() returns http:NoContent|http:NotFound|http:Response {

    // Check if the lecturer with the given staffNumber exists
     if (lecturersTable.hasKey(staffNumber)) {
        // Remove the lecturer's details from the table
        _ = lecturersTable.remove(staffNumber);

        http:Response successResponse = new;
        successResponse.statusCode = http:STATUS_NO_CONTENT;  // Set the status code to 204 (No Content)
        return successResponse;  // Return an empty body with an implicit 204 No Content status
    } else {
        return http:NOT_FOUND;
    }
}


    
    # Retrieve all the lecturers that teach a certain course
    #
    # + courseName - Name of the course 
    # + return - returns can be any of following types
    # Lecturer[] (A list of lecturers teaching the course)
    # http:NotFound (Course not found)
    
    // This endpoint retrieves lecturers teaching a specific course.
    // Service-side: This endpoint responds to the GET request sent by the client's `get lecturers/course/[string courseName]` method.
    resource function get lecturers/course/[string courseName]() returns Lecturer[]|http:NotFound {
    Lecturer[] lecturersTeachingCourse = [];

    // Iterate through the table to find lecturers teaching the specified course
    foreach var lecturer in lecturersTable {
        string[]? coursesOpt = lecturer.courses;
        if (coursesOpt is string[]) {  // Ensure that courses is not nil
            foreach string course in coursesOpt {
                if (course == courseName) {
                    lecturersTeachingCourse[lecturersTeachingCourse.length()] = lecturer;
                    break;  // Break inner loop as we found a matching course
                }
            }
        }
    }
    
    if (lecturersTeachingCourse.length() > 0) {
        return lecturersTeachingCourse;
    } else {
        return http:NOT_FOUND;
    }
    }
    # Retrieve all the lecturers that sit in the same office
    #
    # + officeNumber - Office number 
    # + return - returns can be any of following types
    # Lecturer[] (A list of lecturers in the same office)
    # http:NotFound (Office not found)
    

    // This endpoint retrieves all the lecturers that sit in the same office.
    // Service-side: This endpoint responds to the GET request sent by the client's `get lecturers/office/[string officeNumber]` method.
    resource function get lecturers/office/[string officeNumber]() returns Lecturer[]|http:NotFound {
        Lecturer[] lecturersInSameOffice = [];
    
    // Iterate through the table to find lecturers in the specified office
    foreach var lecturer in lecturersTable {
        if (lecturer.officeNumber == officeNumber) {
            lecturersInSameOffice.push(lecturer);
        }
    }
    
    if (lecturersInSameOffice.length() > 0) {
        return lecturersInSameOffice;
    } else {
        return http:NOT_FOUND;
    }
    }
}
