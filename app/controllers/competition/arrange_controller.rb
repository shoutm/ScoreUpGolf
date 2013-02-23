require 'date'

class Competition::ArrangeController < ApplicationController
  def index
    @today = Date.today
    @years = [@today.year, @today.year + 1] 
    @months = []; (1..12).each do |m| @months << m end
    @days = []; (1..31).each do |d| @days << d end
  end

end
