//1. Retrieve a list of all lecturers within the faculty:
curl http://localhost:9090/lecturers


//2. Add a new lecturer:
First, create a JSON file, e.g., new_lecturer.json, with the following content:
{
  "staffNumber": "L004",
  "name": "Prof. John Doe",
  "courses": ["Math", "Physics"],
  "officeNumber": "O104"
}

//2.5 or IN BASH:
echo '{
  "staffNumber": "L004",
  "name": "Prof. John Doe",
  "courses": ["Math", "Physics"],
  "officeNumber": "O104"
}' > new_lecturer.json

_________________________________________________________________________________

To test if anything was posted
Then, use the following curl command:

curl http://localhost:9090/lecturers/L004


//3.Update an existing lecturer's information:
First, create a JSON file, e.g., update_lecturer.json, with the updated details(IN BASH):

echo '{
  "staffNumber": "L001",
  "name": "Prof. Updated Name",
  "courses": ["Updated Course"],
  "officeNumber": "O105"
}' > updated_lecturer.json

curl -X PUT -H "Content-Type: application/json" -d @updated_lecturer.json http://localhost:9090/lecturers/L001

Test if updated:

 curl http://localhost:9090/lecturers/L001

//4.Delete a lecturer's record by their staff number:

Seemingly works

curl -X DELETE http://localhost:9090/lecturers/L001

//5.Retrieve all the lecturers that teach a certain course.

curl http://localhost:9090/lecturers/course/Computer_Science

//6.Retrieve all the lecturers that sit in the same office:

curl http://localhost:9090/lecturers/office/O101






