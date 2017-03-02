require 'csv'
# allows this file to utilize the Movie class defined in a relative file
require_relative 'movie'

user = {
    "id": 12,
    "likes_old_movies": true,
    "favorite_genres": "Action|Sci-Fi"
}

# parse through the CSV file and uses each row to create a new instance of the Movie class
CSV.foreach('./movie_metadata.csv', :headers=>true) do |row|
  Movie.new(
    title_id: row["movie_imdb_link"].split("/")[4],
    title: row["movie_title"].strip,
    imdb_score: row["imdb_score"].to_f,
    release_year: row["title_year"].to_f,
    genres: row["genres"].split("|")
  )
end

# finds the movie with the matching title id and calls on its fractal_score method
def get_score(movie_title_id)
  Movie.find(movie_title_id).fractal_score
end

# finds the movie with the matching title id and calls on its get_user_score method with an argument of a user hash
def get_user_score(movie_title_id, user_hash)
  Movie.find(movie_title_id).get_user_score(user_hash)
end

# calls on the get_top_10_movies_for_user method for the Movie class with an argument of a user hash
def get_top_10_movies_for_user(user_hash)
  Movie.get_top_10_movies_for_user(user_hash)
end

get_top_10_movies_for_user(user)
