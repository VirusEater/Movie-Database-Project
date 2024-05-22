import MySQLdb
from tabulate import tabulate
import logging

def mysqlconnect():
    #Trying to connect 
    Hostname = 'marmoset05.shoshin.uwaterloo.ca'
    user = 'z443wang'
    password = 'Wzx%030211' 
    database = 'db356_team07'
    try:
        db_connection= MySQLdb.connect(host=Hostname,    
                     user=user,         # your username
                     passwd=password,  # your password
                     db=database)        # name of the data base
    # If connection is not successful
    except:
        print("Can't connect to database")
        return 0
    
    operate = True
    login = False
    userID = None
    while operate: 
        print("----------------------------------------------------------")
        print("Welcome to the Movie Client, implemented by Team-07")
        print("1. search for movies")
        print("2. create a review")
        print("3. modify a review")
        print("4. remove the review")
        print("5. add new movies")
        print("6. sign up")
        print("7. log in")
        print("8. exit")
        option = input("Please enter number 1~7 to access relevant functions: ")

        while not option.isnumeric() or int(option) > 8 or int(option) < 1:
            option = input("Wrong input! Please enter number 1~7 to access relevant functions: ")
        
        # Making Cursor Object For Query Execution
        cursor=db_connection.cursor()

        match option:
            case "1":
                print("Please specify which attribute you want to search")
                print("1. Title")
                print("2. Director")
                print("3. Actor")
                keyword = input("Please enter number 1~3 to access relevant functions: ")
                while not keyword.isnumeric() or int(keyword) > 3 or int(keyword) < 1:
                    keyword = input("Wrong input! Please enter number 1~3 to access relevant functions: ")

                match keyword:
                    case "1":
                        title = input("Please enter movie title: ")
                        limit = input("Please enter number of output rows: ")
                        while not limit.isnumeric() or int(limit) < 0:
                            limit = input("Wrong input! Please enter positive numeric values: ")
                        cursor.execute("select EnglishTitle, tmdbID, year(releaseDate) as year,voteAverage \
                                       from Movies where lower(EnglishTitle) like lower('%" + title + "%') limit " + limit+ ";") 
                        myresult = cursor.fetchall()
                        print(tabulate(myresult, headers=['EnglishTitle','tmdbID', 'year','voteAverage'], tablefmt='psql'))

                    case "2":
                        director = input("Please enter movie director: ")
                        limit = input("Please enter number of output rows: ")                           
                        while not limit.isnumeric() or int(limit) < 0:
                            limit = input("Wrong input! Please enter positive numeric values: ")
                        cursor.execute("select director, Movies.tmdbID, EnglishTitle, year(releaseDate) as year,\
                                        voteAverage from Movies inner join MovieCrewsCasts on Movies.imdbID=MovieCrewsCasts.imdbID \
                                       where lower(director) like lower('%" + director + "%') limit " + limit+ ";")
                        myresult = cursor.fetchall()
                        print(tabulate(myresult, headers=['director', 'tmdbID', 'EnglishTitle', 'year', 'voteAverage'], tablefmt='psql'))  

                    case "3":
                        actor = input("Please enter movie actor: ")
                        limit = input("Please enter number of output rows: ")                           
                        while not limit.isnumeric() or int(limit) < 0:
                            limit = input("Wrong input! Please enter positive numeric values: ")
                        cursor.execute("select main_actor_1,main_actor_2,main_actor_3,main_actor_4, Movies.tmdbID, \
                                       EnglishTitle, year(releaseDate) as year,voteAverage \
                                       from Movies inner join MovieCrewsCasts on Movies.imdbID=MovieCrewsCasts.imdbID \
                                       where lower(main_actor_1) like lower('%" + actor + "%') or lower(main_actor_2) like lower('%" + actor + "%') \
                                       or lower(main_actor_3) like lower('%" + actor + "%') \
                                       or lower(main_actor_4) like lower('%" + actor + "%') limit " + limit+ ";")
                        myresult = cursor.fetchall()
                        print(tabulate(myresult, 
                                       headers=['main_actor_1', 'main_actor_2','main_actor_3','main_actor_4','tmdbID', 'EnglishTitle', 'year','voteAverage'], 
                                       tablefmt='psql'))         
            
            case "2":
                if login is False:
                    print("Please login first!")
                    print("")
                    continue
                tmdbID = input("Please enter movie tmdbID: ")
                rating = input("Please enter movie rating: ")
                try:
                    affected_count = cursor.execute("insert into userRatings (userID, tmdbID, rating) values (" + str(userID) +","+str(tmdbID)+","+ str(rating) +");")
                    db_connection.commit()
                    print(f"Affected Row Count: {affected_count}")
                    print(f"inserted values UserID:{userID}, tmbdID:{tmdbID}, rating:{rating}")
                except MySQLdb.IntegrityError:
                    logging.warning("failed to insert values UserID:%s, tmbdID:%s, rating:%s", userID, tmdbID,rating)

            case "3":
                if login is False:
                    print("Please login first!")
                    print("")
                    continue
                tmdbID = input("Please enter movie tmdbID: ")
                rating = input("Please enter movie rating: ")
                try:
                    affected_count = cursor.execute("update userRatings set rating="+str(rating) +" where userID="+ str(userID) + " and tmdbID=" + str(tmdbID) + ";")
                    db_connection.commit()
                    print(f"Affected Row Count: {affected_count}")
                    print(f"updated values UserID:{userID}, tmbdID:{tmdbID}, rating:{rating}")
                except MySQLdb.IntegrityError:
                    logging.warning("failed to update values UserID:%s, tmbdID:%s, rating:%s", userID, tmdbID,rating)                
            
            case "4":
                if login is False:
                    print("Please login first!")
                    print("")
                    continue
                tmdbID = input("Please enter movie tmdbID: ")
                try: 
                    affected_count = cursor.execute("delete from userRatings where userID="+ str(userID) +" and tmdbID=" + str(tmdbID)+";")
                    db_connection.commit()
                    print(f"Affected Row Count: {affected_count}")
                    print(f"deleted values UserID:{userID}, tmbdID:{tmdbID}")
                except MySQLdb.IntegrityError:
                    logging.warning("failed to delete values UserID:%s, tmbdID:%s", userID, tmdbID) 

            case "5":
                if login is False:
                    print("Pleas login first!")
                    print("")
                    continue
                cursor.execute("select username from Users where userID=" + str(userID) + ";")
                username=cursor.fetchone()[0]
                if username != "Admin":
                    print("You do not have privillege to add movie!")
                    print("")
                    continue
                tmdbID = input("Please enter movie tmdbID: ")
                EnglishTitle = input("Please enter movie English Title: ")
                try: 
                    affected_count = cursor.execute("insert into Movies (tmdbID, EnglishTitle) values (" + str(tmdbID) +",'"+EnglishTitle +"');") 
                    db_connection.commit()
                    print(f"Affected Row Count: {affected_count}")
                    print(f"inserted values tmdbID:{tmdbID}, EnglishTitle:{EnglishTitle}")
                except MySQLdb.IntegrityError:
                    logging.warning("failed to insert values tmdbID:%s, EnglishTitle:%s", tmdbID, EnglishTitle) 

            case "6":
                username = str(input("Please enter username: "))
                password = str(input("Please enter password: "))
                try: 
                    affected_count = cursor.execute("insert into Users (username, password) values ('" + username +"','"+ password +"');")
                    db_connection.commit()
                    print(f"Affected Row Count: {affected_count}")
                    print(f"inserted values username:{username}, password:{password}")
                except MySQLdb.IntegrityError:
                    logging.warning("failed to insert values username:%s, password:%s", username, password) 

            case "7":
                username = str(input("Please enter username: "))
                password = str(input("Please enter password: "))
                cursor.execute("select exists(select * from Users where username='" + username +"' and password='" + password+"');")
                
                result=cursor.fetchone()
                if int(result[0]) != 1:
                    print("Not registered! Please check your user name or password!")
                    continue
                else:
                    print("Login Successful!")
                login = True
                cursor.execute("select userID from Users where username='" + username +"' and password='" + password+"';")
                userID=int(cursor.fetchone()[0])
            case "8":
                operate = False
    
    db_connection.close()
 
# Function Call For Connecting To Our Database
mysqlconnect()


