class WelcomeController < ApplicationController
  def index
    $README_MD=RDiscount.new(open(Rails.root+"README.md").read).to_html
  end
end
