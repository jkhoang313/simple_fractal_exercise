class Movie
  attr_accessor :title_id, :title, :imdb_score, :release_year, :genres
  @@all = []

  def initialize(attributes)
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
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
    movies = self.all.map {|movie| {title: movie.title, score: movie.get_user_score(user_hash)}}

    top_ten = movies.sort {|x, y| y[:score] <=> x[:score]}[0..9]

    puts "Top 10 Recommended Movies"
    top_ten.each.with_index(1) {|movie, index| puts "#{index}. #{movie[:title]} - #{movie[:score]}"}

    top_ten
  end
end
