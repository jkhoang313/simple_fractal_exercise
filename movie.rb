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
end
