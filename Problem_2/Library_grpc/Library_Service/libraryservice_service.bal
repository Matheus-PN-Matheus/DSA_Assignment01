import ballerina/grpc;

listener grpc:Listener ep = new (9090);

@grpc:Descriptor {value: LIBRARY_PROTO_DESC}
service "LibraryService" on ep {

    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
    }
    remote function CreateUsers(StreamUsersRequest value) returns CreateUsersResponse|error {
    }
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
    }
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
    }

    // Lists all available books in the library.
    // Client requests a list of all available books.
   remote function ListAvailableBooks(ListAvailableBooksRequest value) returns ListAvailableBooksResponse|error {
        Book[] availableBooks = [];
        // Filtering out the books that are available.
        foreach var book in books {
            if (book.status) {
                availableBooks.push(book);
            }
        }
        // Sending the list of available books to the client.
        return {books: availableBooks};
    }
 
    // Locates a book based on its ISBN.
    // Client sends an ISBN to locate a specific book.
   remote function LocateBook(LocateBookRequest value) returns LocateBookResponse|error {
        // Searching for the book in the collection using the ISBN provided by the client.
        foreach var book in books {
            if (book.isbn == value.isbn) {
                if (book.status) {
                    // If the book is found and available, return its location to the client.
                    return {location: book.location, status: "Available"};
                } else {
                    // If the book is found but not available, notify the client.
                    return {location: "", status: "Not Available"};
                }
            }
        }
        // If the book isn't found, notify the client.
        return {location: "", status: "Not Found"};
    }
   //This code was add by Denver January_216013216 
  // Allows a user to borrow a book.
    // Client sends a user ID and an ISBN to borrow a specific book.
    remote function BorrowBook(BorrowBookRequest value) returns BorrowBookResponse|error {
        // Searching for the book in the collection using the ISBN provided by the client.
        foreach var book in books {
            if (book.isbn == value.isbn && book.status) {
                // If the book is found and available, mark it as borrowed.
                book.status = false;
                // Notify the client that the book was borrowed.
                return {status: "Borrowed"};
            }
        }
        // If the book isn't available, notify the client.
        return {status: "Not Available"};
    }
}


