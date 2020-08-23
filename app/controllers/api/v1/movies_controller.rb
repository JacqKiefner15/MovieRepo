class Api::V1::MoviesController < ApplicationController

    before_action :set-movie, only: [:show, :update, :destroy]

    skip_before action :authenticate, only: [:index, show]
    #get/movies
    def index
        @movies = Movie.All 
        render json: @movies

    end

    #get/movies/l

    def show 
        @reviews = Review.where(movie_id:params[:id])
        render json: {movie @movie, reviews:@reviews}

    end

    #post /movies

    def create
        @movie = Movie.new(movie_params)
        if @movie.save
            render json: @movie
        else
            render json: @movie.errors, status :unprocessable_entity
        end

    end

    #patch/put /movies.1

    def update
        if @movie.update(movie_params)
            render json: @movie
        else
            render jon: @movie.errors, status :unprocessable_entity
        end

    end


    #delete /movies/1

    def destroy
        @movie.destroy
    end

    # get our Amazon s3 keys for image uploads

    def get_upload_credentials
        @accessKey = ENV['S3_ACCESS']
        @secretKey = ENV['S3_SECRET']
        render json : { accessKey: @accessKey, secretKey: @secretKey}
    end
    
    private
    #methods we write under private can only be accessed in this controller.

    def set_movie
        @Movie = Movie.find(params[:id])
    end

    def movie_params
        params.require(:movie).permit(:title, :description, :parental_rating, :year, :total_gross, :duration, :image, :cast_list, :director)
    end




end


# pagination: creates a certain set of items per page