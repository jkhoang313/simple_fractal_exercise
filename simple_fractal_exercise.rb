require 'csv'
require_relative 'movie'
require 'pry'
user = {
    "id": 12,
    "likes_old_movies": true,
    "favorite_genres": "Action|Sci-Fi"
}

CSV.foreach('./movie_metadata.csv', :headers=>true) do |row|
  Movie.new(title_id: row["movie_imdb_link"].split("/")[4], title: row["movie_title"].strip, imdb_score: row["imdb_score"].to_f, release_year: row["title_year"].to_f, genres: row["genres"].split("|"))
end

def get_score(movie_title_id)
  Movie.find(movie_title_id).fractal_score
end

def get_user_score(movie_title_id, user_hash)
  Movie.find(movie_title_id).get_user_score(user_hash)
end

def get_top_10_movies_for_user(user_hash)
  Movie.get_top_10_movies_for_user(user_hash)
end

get_top_10_movies_for_user(user)
