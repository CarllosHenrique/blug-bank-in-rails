# Homecontroller for home pages
class HomeController < ApplicationController
  before_action :user_auth!

  def index; end
end
