CREATE PROC dbo.GetBooksatBranch 
AS
--Query 1
	SELECT a2.Title, a1.Number_Of_Copies, a3.BranchName
		FROM BookCopies a1
		INNER JOIN Books a2 ON a1.BookID = a2.BookID
		INNER JOIN LibraryBranch a3 ON a1.BranchID = a3.BranchID
		WHERE a3.BranchName = 'Sharpstown' 
		AND a2.Title = 'The Lost Tribe'
	;
GO
;


CREATE PROC dbo.GetCopiesInfo 
AS
--Query 2
	SELECT a1.Number_Of_Copies, a2.Title, a3.BranchName
		FROM BookCopies a1
		INNER JOIN Books a2 ON a1.BookID = a2.BookID
		INNER JOIN LibraryBranch a3 ON a1.BranchID = a3.BranchID
		WHERE a2.Title = 'The Lost Tribe'
	;
GO
;

CREATE PROC dbo.GetBorrowerisNUll 
AS
--Query 3
	SELECT DISTINCT a1.Name
		FROM Borrower a1
		LEFT JOIN BookLoans a2 ON a1.CardNo = a2.CardNo
		WHERE a2.CardNo IS NULL
	;
GO
;

CREATE PROC dbo.GetDueToday
AS
--Query 4
	DECLARE @Today DATE
	SET @Today = GETDATE()

	SELECT a4.Title, a1.Name, a1.Address
		FROM Borrower a1
		INNER JOIN BookLoans a2 ON a2.CardNo = a1.CardNo
		INNER JOIN LibraryBranch a3 ON a3.BranchId = a2.BranchId
		INNER JOIN Books a4 ON a4.BookId = a2.BookId
		WHERE a2.DateDue = @Today 
		AND a3.BranchName = 'Sharpstown'
	;
GO
;

CREATE PROC dbo.GetLoansbyBranch 
AS
--Query 5
	SELECT a1.BranchName, COUNT(DateOut) AS 'Book Loans'
		FROM BookLoans a2
		INNER JOIN LibraryBranch a1 ON a1.BranchID = a2.BranchID
		GROUP BY a1.BranchName
	;
GO
;

CREATE PROC dbo.GetLoansgreaterthan5 
AS
--Query 6
	SELECT a1.Name, a1.Address, COUNT(DateOut) AS '# of Books'
		FROM Borrower a1
		INNER JOIN BookLoans a2 ON a1.CardNo = a2.CardNo
		GROUP BY a1.Name, a1.Address
		HAVING COUNT(DateOut) > 5
	;
GO
;

CREATE PROC dbo.GetBooksbyKing@Central 
AS
--Query 7
	SELECT a4.BranchName, a1.Title, a2.Number_Of_Copies
		FROM Books a1
		INNER JOIN BookCopies a2 ON a1.BookID = a2.BookID
		INNER JOIN BookAuthors a3 ON a3.BookID = a1.BookID
		INNER JOIN LibraryBranch a4 ON a4.BranchID = a2.BranchID
		WHERE a3.AuthorName = 'Stephen King'
		AND a4.BranchName = 'Central'
	;
GO
;