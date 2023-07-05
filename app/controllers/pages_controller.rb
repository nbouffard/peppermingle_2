class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
    @events = Event.all
    @recipes = Recipe.all
  end
end
