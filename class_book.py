class book:
    def __init__(self, title, author, isbn, publication_year, available_copies):
        self.title = title
        self.author = author
        self.isbn = isbn
        self.publication_year = publication_year
        self.available_copies = available_copies
    
    def check_out(self, check_out):
        if check_out > self.available_copies:
            print("Not enough copies available.")
        else:
            self.available_copies -= check_out
            print(f"{check_out} copies checked out successfully.")
            print(f"Available copies: {self.available_copies}")

    def return_book(self,return_book):
        if return_book > self.available_copies:
            print("not enough the book available")
        
        else:
            self.available_copies += return_book
            
            print(f"{return_book} return the book success") 
            print(f"available copies: {self.available_copies}")   
            
            

    def display_book_info(self,display_book_info):
        if display_book_info < self. available_copies:
        
           print("not so the book available copies" )
        
        else:
            display_book_info = self.check_out.available_copies
my_book = book("Lover", "Alekh", "12345", "2022", 5)
my_book.return_book(2)

my_book.display_book_info(10)





        




    

