class WelcomeController < ApplicationController
  def index
    @todos = Todo.order(created_at: :desc).limit(5)
  end
end
