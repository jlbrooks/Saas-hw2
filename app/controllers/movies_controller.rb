class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @request_sort = 'id'
  end

  def index
    @all_ratings = {'G' => 1, 'PG' => 1, 'PG-13' => 1, 'R' => 1} 
    @request_ratings = @all_ratings
    allowable_sorts = [ 'title', 'release_date', 'rating' ]
    @request_sort = params[:sort] unless params[:sort] == nil
    sort_order = 'id'
    if allowable_sorts.include?(@request_sort)
      sort_order = @request_sort
    end
    
    if !params[:ratings]
      redirect_to :action => 'index', :ratings => session[:ratings], :sort => session[:sort]
    else
      @request_ratings = params[:ratings] 
    end
    
    session[:ratings] = @request_ratings
    session[:sort] = @request_sort
    @movies = Movie.where(:rating => @request_ratings.keys).find(:all, :order => sort_order)
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
