module MoviesHelper
  # Checks if a number is odd:
  def oddness(count)
    count.odd? ?  "odd" :  "even"
  end
  
  def decorate_column(column, sort)
    {:class => (sort == column)? 'hilite' : nil }
  end
end
