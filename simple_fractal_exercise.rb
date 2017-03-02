require 'pry'
require 'csv'

user = {
    "id": 12,
    "likes_old_movies": true,
    "favorite_genres": "Action|Sci-Fi"
}

CSV.foreach('./movie_metadata.csv') do |row|
end

# def get_score(movie_title_id)
#
# end
#
# def get_user_score(movie_title_id, user_hash)
#
# end
#
# def get_top_10_movies_for_user(user_hash)
#
# end
