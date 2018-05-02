
from flask import Flask, render_template, request,session,flash,abort,redirect
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import create_engine
import datetime
app = Flask(__name__)
db = SQLAlchemy(app)
DB_URL = 'postgresql+psycopg2://{user}:{pw}@{url}/{db}'.format(user="postgres",pw="root",url="127.0.0.1:5432",db="myapp")

app.config['SQLALCHEMY_DATABASE_URI'] = DB_URL
app.config['SECRET_KEY'] = 'k377AglooNex+932.asdjReajeIxane436'


def sql(rawSql, sqlVars={}):
 "Execute raw sql, optionally with prepared query"
 assert type(rawSql)==str
 assert type(sqlVars)==dict
 res=db.session.execute(rawSql, sqlVars)
 db.session.commit()
 return res




@app.route("/login")
def login_():

  	 return render_template('login.html')

@app.route("/login", methods=['POST'])
def login():
 username = request.form['username'] 
 password = request.form['password']
 user = sql("SELECT * FROM users where username ='%s' AND password = '%s' " % (username,password))

 session['auth_user'] = username
 session['logged_in'] = 1
 if (user.rowcount>0):
  return redirect('books')
 else:
 	return redirect('login')


def GetUserData():
 username = session['auth_user']
 user = sql("SELECT * FROM users where username ='%s' " % (username))
 return user
# Books only 

@app.route("/books")
def books():

 userdata = GetUserData()
 books=sql("SELECT * FROM books JOIN categories ON books.category_id=categories.category_id;")

 return render_template("books/books.html", books=books,userdata=userdata)



@app.route("/books/new")
def new_book():
 userdata = GetUserData()	
 categories = sql("SELECT * FROM categories " )

 return render_template("books/new_book.html", books=books,categories=categories,userdata=userdata)

@app.route("/books/new", methods=['POST'])
def new_book_insert():
 book_name = request.form['book_name'] 
 book_code = request.form['book_code']
 category_id = request.form['book_category']
 price = request.form['book_fee']
 quantity = request.form['book_quantity'] 

 sql("insert into books VALUES( '%s', '%s', '%s', '%s','%s', '%s')" % (book_name, book_code , category_id, price,quantity,quantity))
 return render_template("books/new_book.html")


#Editing ...
@app.route("/books/edit/<id>")
def edit_book(id):
 book_id =id
 books=sql("SELECT * FROM books where id ='%s' " % (book_id))
 categories = sql("SELECT * FROM categories " )
 return render_template("books/edit_book.html", books=books,categories=categories)

@app.route("/books/borrow/<id>")
def borrow_book(id):
 book_id =id
 userdata = GetUserData()
 uid=0
 for u in userdata:
 	uid=u.user_id

 book=sql("SELECT * FROM books where id ='%s' " % (book_id))
 
 sql("insert into borrow(user_id,book_id,borrow_date) VALUES( '%s', '%s', '%s')" % (uid, book_id , datetime.date.today()))
 qty=0
 for u in book:
 	qty=u.available_quantity -1
 sql("update books SET available_quantity ='%s' where id ='%s' " % (qty,book_id))
 #sql("delete from borrow")

 return  redirect('books')

@app.route("/books/update/<id>", methods=['POST'])
def update_book(id):
   book_id =id
   book_name = request.form['book_name']
   book_code = request.form['book_code']
   category_id = request.form['book_category']
   price = request.form['book_fee']
   quantity = request.form['book_quantity'] 

   sql("update books SET name ='%s' , book_code ='%s' ,category_id ='%s',price ='%s' ,quantity ='%s' where id ='%s' " % (book_name,book_code,category_id,price,quantity,book_id))
   return  redirect('books')





@app.route("/books/delete/<id>")
def delete_book(id):
 book_id =id
 sql("delete  from books where id ='%s' " % (book_id))

 return  redirect('books')

#Ending Books

#Users
@app.route("/users")
def users():
 
 users=sql("SELECT * FROM users ;")

 return render_template("users/users.html", users=users)



@app.route("/users/new")
def new_user():
 

 return render_template("users/new_user.html")

@app.route("/users/new", methods=['POST'])
def new_user_insert():

			
 first_name = request.form['first_name'] 
 last_name = request.form['last_name']
 role = request.form['role']
 phone = request.form['phone']
 username = request.form['username']
 password = request.form['password']
 password2 = request.form['password_2'] 
 if password==password2:
  sql("insert into users(username,password,phone,role,first_name,last_name) VALUES( '%s', '%s', '%s', '%s','%s', '%s')" % (username, password , phone, role,first_name,last_name))
 else:
  redirect('users/new_user')
 return redirect('users')


#Editing ...
@app.route("/users/edit/<id>")
def edit_user(id):
 user_id =id
 users=sql("SELECT * FROM users where user_id ='%s' " % (user_id))
 return render_template("users/edit_user.html", users=users)

@app.route("/users/update/<id>", methods=['POST'])
def update_user(id):
   user_id =id
   first_name = request.form['first_name'] 
   last_name = request.form['last_name']
   role = request.form['role']
   phone = request.form['phone']
   username = request.form['username']
   password = request.form['password']
   password2 = request.form['password_2'] 

   sql("update users SET first_name ='%s' , last_name ='%s' ,role ='%s',phone ='%s' ,username ='%s',password ='%s' where user_id ='%s' " % (first_name,last_name,role,phone,username,password,user_id))
   return  redirect('users')





@app.route("/users/delete/<id>")
def delete_user(id):
 user_id =id
 sql("delete  from users where user_id ='%s' " % (user_id))

 return  redirect('users')
#Ending Users


#Categories
@app.route("/categories")
def categories():
 
 categories=sql("SELECT * FROM categories ;")

 return render_template("categories/categories.html", categories=categories)



@app.route("/categories/new")
def new_category():
 

 return render_template("categories/new_category.html")

@app.route("/categories/new", methods=['POST'])
def new_category_insert():

			
 category_name = request.form['category_name'] 
 
 sql("insert into categories(category_name) VALUES( '%s')" % (category_name))
 
  
 return redirect('categories')


#Editing ...
@app.route("/categories/edit/<id>")
def edit_category(id):
 category_id =id
 categories=sql("SELECT * FROM categories where category_id ='%s' " % (category_id))
 return render_template("categories/edit_category.html", categories=categories)

@app.route("/categories/update/<id>", methods=['POST'])
def update_category(id):
   category_id =id
   category_name = request.form['category_name'] 
   

   sql("update categories SET category_name ='%s'  where category_id ='%s' " % (category_name,category_id))
   return  redirect('categories')





@app.route("/categories/delete/<id>")
def delete_category(id):
 category_name =id
 sql("delete  from categories where category_id ='%s' " % (category_name))

 return  redirect('categories')
#Ending Categories

@app.route("/operations")
def operations():
 operations= sql("select * from borrow JOIN books on borrow.book_id=books.id JOIN users on users.user_id = borrow.user_id")

 return render_template("operations.html",operations=operations)


@app.route("/logout")
def logout():
 session.pop('auth_user')
 session.pop('logged_in')
 return redirect('/login')

@app.route("/home")
def home():
  	 return render_template('home.html')

@app.route("/animals")
def animals():
 animals=sql("SELECT * FROM animals;")
 return render_template("animals.html", animals=animals)

if __name__ == "__main__":
 from flask_sqlalchemy import get_debug_queries
 app.run(debug=True)