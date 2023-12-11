# app/controllers/about_controller.rb
class AboutController < ApplicationController
    def index
      @about_page = AboutPage.first
    end
  end
  