
//***THIS 2023 DSA612S ASSIGNMENT WAS DONE BY***
//--1. A-Jay Steyn -- 222082429
//--2. Denver January -- 216013216
//--3. Matheus PN Matheus -- 220075921
//--4. Mushe Mulauli -- 221094296

import ballerina/grpc;

// Initiating a gRPC listener on port 9090.
listener grpc:Listener ep = new (9090);

// LibraryService definition with the associated Protocol Buffers descriptor.
@grpc:Descriptor {value: LIBRARY_PROTO_DESC}
service "LibraryService" on ep {
    
    // Adds a book to the library collection.
    // Client sends a request with book details to add it to the library.
    remote function AddBook(AddBookRequest value) returns AddBookResponse|error {
        // Constructing a new book from the client's request.
        Book newBook = {
            title: value.title,
            author_1: value.author_1,
            author_2: value.author_2,
            location: value.location,
            isbn: value.isbn,
            status: value.status
        };
        // Adding the new book to the books collection.
        books.push(newBook);
        // Responding to the client with the ISBN of the added book.
        return {isbn: value.isbn};
    }

    // Creates new users (either students or librarians).
    // Client sends a list of users to be added.
    remote function CreateUsers(StreamUsersRequest value) returns CreateUsersResponse|error {
        // Iterating through the users sent by the client and adding them.
        foreach User user in value.users {
            users.push(user);
        }
        // Responding to the client that users were added successfully.
        return {status: "Success"};
    }

    // Updates the details of an existing book.
    // Client sends details of a book to be updated based on its ISBN.
    remote function UpdateBook(UpdateBookRequest value) returns UpdateBookResponse|error {
        // Searching for the book in the collection using the ISBN provided by the client.
        foreach var book in books {
            if (book.isbn == value.isbn) {
                // If the book is found, update its details.
                book.title = value.title;
                book.author_1 = value.author_1;
                book.author_2 = value.author_2;
                book.location = value.location;
                // Notify the client that the book was updated.
                return {status: "Updated"};
            }
        }
        // If the book isn't found, notify the client.
        return {status: "Not Found"};
    }

    // Removes a book from the library collection.
    // Client sends an ISBN of a book to be removed.
    remote function RemoveBook(RemoveBookRequest value) returns RemoveBookResponse|error {
        int indexToRemove = -1;
        // Searching for the book in the collection using the ISBN provided by the client.
        foreach var [i, book] in books.enumerate() {
            if (book.isbn == value.isbn) {
                indexToRemove = i;
                break;
            }
        }
        if (indexToRemove != -1) {
            // If the book is found, remove it from the collection.
            _ = books.remove(indexToRemove);
        }
        // Return the current list of books to the client after the removal.
        return {books: books};
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
