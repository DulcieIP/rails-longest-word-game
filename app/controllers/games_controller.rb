require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    # new action will be used to display a new random grid and a form
    #  generate an Array of ten random letters
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    # . The form "new" will be submitted (with POST) to the score action.
    @suggestion = params[:suggestion]
    @letters = params[:letters].split

    url = "https://wagon-dictionary.herokuapp.com/#{@suggestion}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    @suggestion_array = @suggestion.chars

    if user["found"]
      if @suggestion_array.all? { |letter| @suggestion_array.count(letter) <= @letters.count(letter)}
        @answer = "Congratulations! #{@suggestion} is a valid English word!"
      else
        @answer = "Sorry but #{@suggestion} can't be built ou of #{@letters.join(", ").upcase}"
      end
    else
      @answer = "Sorry but #{@suggestion} does not seem to be a valid English word... "
    end
  end
end
