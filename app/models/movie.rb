class Movie < ActiveRecord::Base
  def all_ratings
    ['G', 'PG', 'PG-13', 'R']
  end
end
