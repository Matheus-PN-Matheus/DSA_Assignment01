import ballerina/io;
import ballerina/grpc;

LibraryServiceClient ep = check new ("http://localhost:9090");
public function main() returns error? {
    // Add a book using the client
    AddBookRequest addBookReq = {
        title: "Sample Book",
        author_1: "Author A",
        author_2: "Author B",
        location: "Shelf 101",
        isbn: "123456",
        status: true
    };
    var addBookResp = ep->AddBook(addBookReq);
    handleResponse(addBookResp);

    // Create a user
    StreamUsersRequest createUserReq = {users: [{id: "user123", "type": "STUDENT"}]};
    var createUserResp = ep->CreateUsers(createUserReq);
    handleResponse(createUserResp);

    // Update a book
    UpdateBookRequest updateBookReq = {
        isbn: "123456",
        title: "Updated Book Title",
        author_1: "Updated Author A",
        author_2: "Updated Author B",
        location: "Shelf 102"
    };
    var updateBookResp = ep->UpdateBook(updateBookReq);
    handleResponse(updateBookResp);

    // Remove a book
    RemoveBookRequest removeBookReq = {isbn: "123456"};
    var removeBookResp = ep->RemoveBook(removeBookReq);
    handleResponse(removeBookResp);

    // List available books
    ListAvailableBooksRequest listBooksReq = {};
    var listBooksResp = ep->ListAvailableBooks(listBooksReq);
    handleResponse(listBooksResp);

    // Locate a book
    LocateBookRequest locateBookReq = {isbn: "123456"};
    var locateBookResp = ep->LocateBook(locateBookReq);
    handleResponse(locateBookResp);

    // Borrow a book
    BorrowBookRequest borrowBookReq = {user_id: "user123", isbn: "123456"};
    var borrowBookResp = ep->BorrowBook(borrowBookReq);
    handleResponse(borrowBookResp);
}

function handleResponse(AddBookResponse|CreateUsersResponse|UpdateBookResponse|RemoveBookResponse|ListAvailableBooksResponse|LocateBookResponse|BorrowBookResponse|grpc:Error response) {
    if (response is grpc:Error) {
        io:println("Error:", response.message());
    } else {
        io:println(response);
    }
}
