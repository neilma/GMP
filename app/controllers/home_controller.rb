class HomeController < ApplicationController
  include ApplicationHelper

  def index
  end

  def login
    popup_login_form
  end
end