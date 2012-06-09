class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    @request_sort = 'id'
  end

  def index
    @all_ratings = ['G', 'PG', 'PG-13', 'R']
    @request_ratings = @all_ratings
    allowable_sorts = [ 'title', 'release_date', 'rating' ]
    @request_sort = params[:sort] unless params[:sort] == nil
    sort_order = 'id'
    if allowable_sorts.include?(@request_sort)
      sort_order = @request_sort
    end
    @request_ratings = params[:ratings].keys unless params[:ratings] == nil
    @movies = Movie.where(:rating => @request_ratings).find(:all, :order => sort_order)
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
