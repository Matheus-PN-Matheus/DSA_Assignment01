import ballerina/http;
import ballerina/io;

// In-memory data store for lecturers
map<int, json> lecturers = {};

service /lecturers on new http:Listener(9090) {
    resource function get getAllLecturers() returns json[] {
        json[] lecturerList = lecturers.values();
        return lecturerList;
    }

    resource function post addLecturer(json lecturer) returns json {
        int staffNumber = lecturer.staffNumber;
        lecturers[staffNumber] = lecturer;
        return lecturer;
    }

    resource function get getLecturerByStaffNumber(int staffNumber) returns json {
        json? lecturer = lecturers[staffNumber];
        if (lecturer != null) {
            return lecturer;
        } else {
            // Return a 404 Not Found response
            check http:NotFound("Lecturer not found");
        }
    }

    resource function put updateLecturer(int staffNumber, json updatedLecturer) returns json {
        json? existingLecturer = lecturers[staffNumber];
        if (existingLecturer != null) {
            lecturers[staffNumber] = updatedLecturer;
            return updatedLecturer;
        } else {
            // Return a 404 Not Found response
            check http:NotFound("Lecturer not found");
        }
    }

    resource function delete deleteLecturer(int staffNumber) {
        json? existingLecturer = lecturers[staffNumber];
        if (existingLecturer != null) {
            lecturers.remove(staffNumber);
        } else {
            // Return a 404 Not Found response
            check http:NotFound("Lecturer not found");
        }
    }
}
