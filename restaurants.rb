require 'singleton'
require 'sqlite3'

class RestaurantReview < SQLite3::Database
  include Singleton

  def initialize
    # tell the SQLite3::Database the db file to read/write
    super("restaurant_info.db")

    # otherwise we get an array of values
    self.results_as_hash = true
    # otherwise everything is returned as a string
    self.type_translation = true
  end
end

def fill_tables

  add_chef("John", "Theodore", "Ned")
  add_chef("Ned", "Ruggeri", "Kush")
  add_chef("John", "Smith", "Adam")
  add_chef("Jane", "Doe", "Sara")
  add_chef("Vincent", "Chang", "Jane")

  add_restaurant("La Taqueria", "Mission", "Mexican")
  add_restaurant("Yokimura", "Embarcadero", "Japanese")
  add_restaurant("It's Amore", "Tenderloin", "Italian")
  add_restaurant("Mandarin Gourmet", "Embarcadero", "Chinese")
  add_restaurant("Mi Casa", "Tenderloin", "Mexican")

  add_head_chef_tenures(1, 2, "2012-01-01", "2012-06-12")
  add_head_chef_tenures(2, 3, "2012-06-01", "2012-10-12")
  add_head_chef_tenures(3, 1, "2011-01-01", "2012-02-12")
  add_head_chef_tenures(4, 4, "2012-03-01", "2013-01-10")
  add_head_chef_tenures(5, 5, "2008-05-12", "2010-03-08")

  add_critic("ilovefood")
  add_critic("burritoman")
  add_critic("nedlicious")
  add_critic("kushlicious")
  add_critic("yumyum")

  add_restaurant_reviews(1, 1, "La Taqueria", "This place sucks", 2, "2012-05-01")
  add_restaurant_reviews(2, 2, "Yokimura", "This place is awesome", 5, "2012-03-01")
  add_restaurant_reviews(3, 3, "It's Amore", "This place is OK", 3, "2012-07-01")
  add_restaurant_reviews(4, 4, "Mandarin Gourmet", "This place is terrible", 1, "2012-11-01")
  add_restaurant_reviews(5, 5, "Mi Casa", "Great tacos", 4, "2009-04-01")
  add_restaurant_reviews(1, 3, "It's Amore", "Great food, bad service", 3, "2012-07-13")
  add_restaurant_reviews(2, 4, "Mandarin Gourmet", "Pretty good", 3, "2012-08-28")

end

def get_chef
  # execute a SELECT; result in an `Array` of `Hash`es, each
  # represents a single row.
  RestaurantReview.instance.execute("SELECT * FROM chefs")
end

def add_chef(first_name, last_name, mentor)
  RestaurantReview.instance.execute( "INSERT INTO chefs ('first_name', 'last_name', 'mentor') 
    VALUES (?, ?, ?)", first_name, last_name, mentor)
end

def add_restaurant(name, neighborhood, cuisine)
  RestaurantReview.instance.execute( "INSERT INTO restaurants ('name', 'neighborhood', 'cuisine') 
    VALUES (?, ?, ?)", name, neighborhood, cuisine)
end

def add_head_chef_tenures(chef_id, restaurant_id, start_date, end_date)
  RestaurantReview.instance.execute( "INSERT INTO head_chef_tenures ('chef_id', 'restaurant_id', 'start_date', 'end_date') 
    VALUES (?, ?, ?, ?)", chef_id, restaurant_id, start_date, end_date)
end

def add_critic(screen_name)
  RestaurantReview.instance.execute( "INSERT INTO critic ('screen_name') VALUES (?)", screen_name)
end

def add_restaurant_reviews(critic_id, restaurant_id, name, text_review, score, date_of_review)
  RestaurantReview.instance.execute( "INSERT INTO restaurant_reviews ('critic_id', 'restaurant_id', 'name', 'text_review', 'score', 'date_of_review') 
    VALUES (?, ?, ?, ?, ?, ?)", critic_id, restaurant_id, name, text_review, score, date_of_review)
end


def query_chef(lastname)
  RestaurantReview.instance.execute("SELECT * from chefs WHERE last_name='#{lastname}'")
end


def rm_chef(first_name, last_name, mentor)
  # execute an INSERT; the '?' gets replaced with the value name. The
  # '?' lets us separate SQL commands from data, improving
  # readability, and also safety (lookup SQL injection attack on
  # wikipedia).
RestaurantReview.instance.execute( "INSERT INTO chefs ('first_name', 'last_name', 'mentor') 
    VALUES (?, ?, ?)", first_name, last_name, mentor)
end

def add_professor(first_name, last_name, title, department_id)
  # insert a multi-column row; the '?' marks get replaced one by one.
  RestaurantReview.instance.execute(
    "DELETE FROM chefs WHERE ('first_name, 'last_name', 'title', 'department_id') VALUES (?, ?, ?, ?)",
    first_name, last_name, title, department_id)
end
