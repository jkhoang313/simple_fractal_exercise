class Movie
  attr_accessor :title_id, :title, :imdb_score, :release_year, :genres
  # class variable @@all to keep track of all instances of the Movie class created
  @@all = []

  def initialize(attributes)
    # utilizes :send to initialize attributes of instances of Movie class
    attributes.each do |key, value|
      self.send("#{key}=", value)
    end
    @@all << self
  end

  # could alternatively do...

  # def initialize(title_id, title, imdb_score, release_year, genres)
  #   @title_id = title_id
  #   @title = title.strip
  #   @imdb_score = imdb_score.to_f
  #   @release_year = release_year.to_f
  #   @genres = genres
  #   @@all << self
  # end

  def fractal_score
    # sets a variable "bonus" to either 1.5 or 0 depending on whether it has a genre of "Fantasy"or "Sci-Fi"
    bonus = genres.include?("Fantasy") || genres.include?("Sci-Fi") ? 1.5 : 0

    # Fractal movie score formula
    2.3 * imdb_score - (release_year / 2000) + bonus
  end

  def self.all
    # returns an array of all instances of the Movie class
    @@all
  end

  def self.find(id)
    # returns the instance of the Movie class that matches the id given
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
    # checks two conditions(likes_old_movies and favorite_genres) and adds a value depending on whether it passes either of the conditions
    self.fractal_score + bonus
  end

  def self.get_top_10_movies_for_user(user_hash)
    # maps all instances of the Movie class and returns a hash containing its title and fractal_score for each instance
    # stored in a movies variable
    movies = self.all.map {|movie| {title: movie.title, score: movie.get_user_score(user_hash)}}

    # sorts the newly created movies array by descending fractal_score and returns the 10 highest scores
    top_ten = movies.sort {|x, y| y[:score] <=> x[:score]}[0..9]

    # prints out a list to the console with its ranking for a better user experience
    puts "Top 10 Recommended Movies"
    top_ten.each.with_index(1) {|movie, index| puts "#{index}. #{movie[:title]} - #{movie[:score]}"}

    # returns the top ten list in an array
    top_ten
  end
end
