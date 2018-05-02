@app.route("/books")
def books():
 
 books=sql("SELECT * FROM books;")
 return render_template("books/books.html", books=books)


@app.route("/books/new")
def new_book():
 
 
 return render_template("books/new_book.html", books=books)

@app.route("/books/new", methods=['POST'])
def new_book_insert():
 book_name = request.form['book_name'] 
 book_code = request.form['book_code']
 category_id = request.form['book_category']
 price = request.form['book_fee']
 quantity = request.form['book_quantity'] 

 sql("insert into books VALUES( '%s', '%s', '%s', '%s','%s', '%s')" % (book_name, book_code , category_id, price,quantity,quantity))
#sql = "insert into books VALUES( '%s', '%s', %d, %d,%d, %d)" % (book_name, book_code , category_id, price,quantity,available_quantity)
 return render_template("books/new_book.html")