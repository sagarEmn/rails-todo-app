require 'rails_helper'

RSpec.describe "Todos API", type: :request do
  describe "GET /api/todos" do
    before do
      Todo.create(title: 'First Todo')
      Todo.create(title: 'Second Todo')
    end

    it "returns all todos" do
      get "/api/todos"
      
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).size).to eq(2)
    end
  end

  describe "GET /api/todos/:id" do
    let(:todo) { Todo.create(title: 'Test Todo', description: 'Test Description') }

    it "returns the todo" do
      get "/api/todos/#{todo.id}"
      
      expect(response).to have_http_status(:success)
      
      json = JSON.parse(response.body)
      expect(json['title']).to eq('Test Todo')
      expect(json['description']).to eq('Test Description')
    end
  end
end