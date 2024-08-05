require "json"
require "open-uri"

class GamesController < ApplicationController
  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split('')
    url = "https://dictionary.lewagon.com/#{@word}"
    user_serialized = URI.open(url).read
    user = JSON.parse(user_serialized)

    @word.split('').each do |letter|
      if @letters.include?(letter) == false
        @result = 'Sorry but your word contains other letters than the ones in the grid.'
      elsif user['found'] == false
        @result = 'Sorry, your word is not an english word.'
      else
        @result = 'Congrats !'
      end
    end
  end
end
