class Movie
  attr_accessor :title_id, :imdb_score, :release_year, :genres
  @@all = []

  def initialize(title_id, imdb_score, release_year, genres)
    @title_id = title_id
    @imdb_score = imdb_score.to_f
    @release_year = release_year.to_f
    @genres = genres
    @@all << self
  end

  def fractal_score
    bonus = genres.include?("Fantasy") || genres.include?("Sci-Fi") ? 1.5 : 0

    2.3 * imdb_score - (release_year / 2000) + bonus
  end

  def self.all
    @@all
  end

  def self.find(id)
    self.all.find {|movie| movie.title_id == id}
  end

  def get_user_score(user_hash)
    bonus = 0
    if user_hash[:likes_old_movies] && self.release_year < 1970
      bonus += 2.5
    end
    if !(user_hash[:favorite_genres].split("|") & self.genres).empty?
      bonus += 3.5
    end
    self.fractal_score + bonus
  end

  def self.get_top_10_movies_for_user(user_hash)

  end
end
