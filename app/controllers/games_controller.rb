require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = (0...10).map { ('a'..'z').to_a[rand(26)] }
    if params[:word]
      @word = :word
    end
  end

  def score
    @word = params[:word]
    @letters = params[:letters]
    filepath = "https://wagon-dictionary.herokuapp.com/#{@word}"
    word_results = URI.open(filepath).read
    answers = JSON.parse(word_results)
    # raise
    if @word.chars.all? {|letter| @word.downcase.count(letter.downcase) <= @letters.downcase.count(letter.downcase)} && answers["found"] == true
      @output = "Congratualtions, #{@word} is a valid word that can be built out of: #{@letters}"
    elsif @word.chars.all? {|letter| @word.downcase.count(letter.downcase) <= @letters.downcase.count(letter.downcase)} && answers["found"] == false
      @output = "Sorry but #{@word} is anot an english word"
    else
      @output = "#{@word} cannot be built with #{@letters}"
    end
  end
end
