CREATE DATABASE db_Library
GO

USE db_Library
GO

CREATE PROCEDURE createLibraryDB
AS
BEGIN
	CREATE TABLE LibraryBranch (
		BranchID INT PRIMARY KEY NOT NULL IDENTITY (1,1),
		BranchName VARCHAR(50) NOT NULL,
		[Address] VARCHAR(60) NOT NULL
	);

	CREATE TABLE Publisher (
		PublisherName VARCHAR(50) PRIMARY KEY NOT NULL,
		[Address] VARCHAR(60) NOT NULL,
		Phone VARCHAR(12) NOT NULL
	);

	CREATE TABLE Books (
		BookID INT PRIMARY KEY NOT NULL IDENTITY (100,1),
		Title VARCHAR(60) NOT NULL,
		PublisherName VARCHAR(50) CONSTRAINT fk_Books_Publisher FOREIGN KEY (PublisherName) REFERENCES Publisher(PublisherName) ON UPDATE CASCADE ON DELETE CASCADE
	);

	CREATE TABLE BookCopies (
		BookID INT CONSTRAINT fk_BookCopies_Books FOREIGN KEY (BookID) REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT CONSTRAINT fk_BookCopies_LibraryBranch FOREIGN KEY REFERENCES LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		Number_Of_Copies INT NOT NULL
	);

	CREATE TABLE BookAuthors (
		BookID INT CONSTRAINT fk_BookAuthors_Books FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		AuthorName VARCHAR(60) NOT NULL
	);

	CREATE TABLE Borrower (
		CardNo INT PRIMARY KEY NOT NULL IDENTITY (2000,1),
		[Name] VARCHAR(50) NOT NULL,
		[Address] VARCHAR(60) NOT NULL,
		Phone VARCHAR(50) NOT NULL
	);

	CREATE TABLE BookLoans (
		BookID INT CONSTRAINT fk_BookLoans_Books FOREIGN KEY REFERENCES Books(BookID) ON UPDATE CASCADE ON DELETE CASCADE,
		BranchID INT CONSTRAINT fk_BookLoans_LibraryBranch FOREIGN KEY REFERENCES LibraryBranch(BranchID) ON UPDATE CASCADE ON DELETE CASCADE,
		CardNo INT CONSTRAINT fk_BookLoans_Borrower FOREIGN KEY REFERENCES Borrower ON UPDATE CASCADE ON DELETE CASCADE,
		DateOut DATE NOT NULL,
		DateDue DATE NOT NULL
	);

	INSERT INTO Publisher
		(PublisherName, Address, Phone)
		VALUES
		('Picador','United Kingdom', '985-762-1649'),
		('Scribner','153–157 Fifth Avenue, New York City', '486-952-1379'),
		('Viking Press','New York City', '168-794-4596'),
		('Doubleday','New York City', '456-123-7915'),
		('Bantam Spectra','New York City', '753-951-4682'),
		('Bloomsbury','WC1, London, England', '134-951-6298'),
		('Faber and Faber','London, England', '429-763-9853')
	;
	SELECT * FROM Publisher

	INSERT INTO Books
		(Title, PublisherName)
		VALUES
		('The Lost Tribe', 'Picador'),
		('The Shining', 'Scribner'),
		('It','Viking Press'),
		('Salem''s lot','Doubleday'),
		('Dracula','Bantam Spectra'),
		('Alice''s Adventures in Wonderland','Bloomsbury'),
		('The Wizard of OZ','Faber and Faber'),
		('Twenty Thousand leagues under the Sea','Picador'),
		('The Hobbit','Scribner'),
		('To Kill A Mockingbird','Viking Press'),
		('The Great Gatsby','Doubleday'),
		('The Lord of the Rings','Bantam Spectra'),
		('Dune','Bloomsbury'),
		('A Game of Thrones','Faber and Faber'),
		('The Sword of Truth','Picador'),
		('Do Androids Dream of Electric Sheep?','Scribner'),
		('Harry Potter and the Philosopher''s Stone','Viking Press'),
		('Frankenstein','Doubleday'),
		('Lord of the Flies','Bantam Spectra'),
		('The Old Man and the Sea','Bloomsbury')
	;
	SELECT * FROM Books

	INSERT INTO BookAuthors
		(BookID, AuthorName)
		VALUES
		(100,'Edward Marriot'),
		(101,'Stephen King'),
		(102, 'Stephen King'),
		(103,'Stephen King'),
		(104,'Bram Stoker'),
		(105,'Lewis Carroll'),
		(106,'Frank L. Baum'),
		(107,'Jules Verne'),
		(108,'J.R.R.Tolkien'),
		(109,'Harper LEE'),
		(110,'F. Scott Fitzgerald'),
		(111,'J.R.R.Tolkien'),
		(112,'Frank Herbert'),
		(113,'George R.R. Martin'),
		(114,'Terry Goodkind'),
		(115,'Philip K. Dick'),
		(116,'J.K.Rowling'),
		(117,'Mary Shelly'),
		(118,'William Golding'),
		(119,'Ernest Hemingway')
	;
	SELECT * FROM BookAuthors

	INSERT INTO LibraryBranch
		(BranchName, [Address])
		VALUES
		('Sharpstown','123 N 4th street'),
		('Central','432 S 1st ave'),
		('Division','987 W 6th drive'),
		('Groomsville', '678 E 9th Ave')
	;
	SELECT * FROM LibraryBranch

	INSERT INTO BookCopies
		(BookID, BranchID, Number_of_Copies)
		VALUES
		(100,1,25),
		(101,2,30),
		(102,2,12),
		(103,3,10),
		(104,4,10),
		(105,1,3),
		(106,2,12),
		(107,3,8),
		(108,4,7),
		(109,4,6),
		(110,3,12),
		(111,2,14),
		(112,4,19),
		(113,1,27),
		(114,1,15),
		(115,3,10),
		(116,2,8),
		(117,4,7),
		(118,3,11),
		(119,1,9),
		(100,2,25),
		(101,3,30),
		(102,3,12),
		(103,4,10),
		(104,1,10),
		(105,2,3),
		(106,3,12),
		(107,4,8),
		(108,1,7),
		(109,1,6),
		(110,4,12),
		(111,3,14),
		(112,1,19),
		(113,2,27),
		(114,2,15),
		(115,4,10),
		(116,3,8),
		(117,1,7),
		(118,4,11),
		(119,2,9)
	;
	SELECT * FROM BookCopies

	INSERT INTO Borrower
		(Name, Address, Phone)
		VALUES
		('John Smith','456 W 12th Ave','156-453-4862'),
		('James Franken','159 E 6th St','156-954-7529'),
		('Frank Williams','759 S jones St','156-503-4891'),
		('Manny Coulter','421 W Williams Dr','156-282-4985'),
		('Susan Delaware','156 N Round St','156-486-1975'),
		('Amy Johnson','394 S Broadway Dr','156-329-8056'),
		('Ana Richardson','967 N Campfire Lane','156-895-0567'),
		('Anthony Taco','768 Truck Dr','156-483-1308'),
		('Richard Quetives', '453 S Meade Ave', '156-805-3753')
	;
	SELECT * FROM Borrower

	INSERT INTO BookLoans
		(BookID, BranchID, CardNo, DateOut, DateDue)
		VALUES
		(100,1,2000,'2020-01-23','2020-02-23'),
		(101,2,2000,'2020-01-17','2020-02-17'),
		(100,2,2000,'2020-01-17','2020-02-17'),
		(102,2,2000,'2020-01-17','2020-02-17'),
		(105,1,2000,'2020-01-23','2020-02-23'),
		(106,2,2001,'2020-01-03','2020-02-03'),
		(107,3,2001,'2020-01-07','2020-02-07'),
		(108,4,2001,'2020-01-12','2020-02-12'),
		(109,4,2001,'2020-01-12','2020-02-12'),
		(110,3,2001,'2020-01-07','2020-02-07'),
		(111,2,2001,'2020-01-03','2020-02-03'),
		(112,4,2001,'2020-01-12','2020-02-12'),
		(113,1,2001,'2020-01-16','2020-02-16'),
		(114,1,2001,'2020-01-16','2020-02-16'),
		(115,3,2001,'2020-01-07','2020-02-07'),
		(100,1,2002,'2020-01-02','2020-02-02'),
		(102,2,2002,'2020-01-05','2020-02-05'),
		(104,4,2002,'2020-01-12','2020-02-12'),
		(106,2,2002,'2020-01-05','2020-02-05'),
		(108,4,2002,'2020-01-12','2020-02-12'),
		(110,3,2002,'2020-01-20','2020-02-20'),
		(112,4,2002,'2020-01-12','2020-02-12'),
		(114,1,2002,'2020-01-02','2020-02-02'),
		(116,2,2002,'2020-01-05','2020-02-05'),
		(101,3,2003,'2020-01-18','2020-02-18'),
		(103,4,2003,'2020-01-27','2020-02-27'),
		(105,2,2003,'2020-01-12','2020-02-12'),
		(107,4,2003,'2020-01-27','2020-02-27'),
		(109,1,2003,'2020-01-07','2020-02-07'),
		(111,3,2003,'2020-01-18','2020-02-18'),
		(113,2,2003,'2020-01-12','2020-02-12'),
		(115,4,2003,'2020-01-27','2020-02-27'),
		(117,1,2003,'2020-01-07','2020-02-07'),
		(119,2,2003,'2020-01-12','2020-02-12'),
		(100,1,2004,'2020-01-06','2020-02-06'),
		(101,2,2004,'2020-01-02','2020-02-02'),
		(103,3,2004,'2020-01-14','2020-02-14'),
		(104,1,2004,'2020-01-06','2020-02-06'),
		(106,3,2004,'2020-01-14','2020-02-14'),
		(107,3,2005,'2020-01-09','2020-02-09'),
		(109,4,2005,'2020-01-10','2020-02-10'),
		(111,2,2005,'2020-01-01','2020-02-01'),
		(112,4,2005,'2020-01-10','2020-02-10'),
		(114,1,2005,'2020-01-01','2020-02-01'),
		(112,4,2006,'2020-01-11','2020-02-11'),
		(119,1,2007,'2020-01-05','2020-02-05'),
		(112,1,2007,'2020-01-05','2020-02-05'),
		(110,4,2007,'2020-01-07','2020-02-07'),
		(103,4,2007,'2020-01-07','2020-02-07'),
		(107,4,2007,'2020-01-07','2020-02-07')
	;
	SELECT * FROM BookLoans

	;
END

EXEC [dbo].[createLibraryDB]