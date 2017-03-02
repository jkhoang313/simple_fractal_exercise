require 'pry'
require 'csv'
require_relative 'movie'

user = {
    "id": 12,
    "likes_old_movies": true,
    "favorite_genres": "Action|Sci-Fi"
}

CSV.foreach('./movie_metadata.csv', :headers=>true) do |row|
  Movie.new(row["movie_imdb_link"].split("/")[4], row["imdb_score"], row["title_year"], row["genres"].split("|"))
end


def get_score(movie_title_id)
  Movie.get_score(movie_title_id)
end

def get_user_score(movie_title_id, user_hash)
  Movie.get_user_score(movie_title_id, user_hash)
end

# def get_top_10_movies_for_user(user_hash)
#
# end
