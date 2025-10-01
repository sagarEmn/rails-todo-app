require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'validations' do
    it 'is valid with a title' do
      todo = Todo.new(title: 'Test Todo')
      expect(todo).to be_valid
    end

    it 'is invalid without a title' do
      todo = Todo.new(title: nil)
      todo.valid?
      expect(todo.errors[:title]).to include("can't be blank")
    end
  end

  describe 'scopes' do
    before do
      @completed_todo = Todo.create(title: 'Completed Todo', completed: true)
      @pending_todo = Todo.create(title: 'Pending Todo', completed: false)
    end

    it 'returns completed todos' do
      expect(Todo.completed).to include(@completed_todo)
      expect(Todo.completed).not_to include(@pending_todo)
    end

    it 'returns pending todos' do
      expect(Todo.pending).to include(@pending_todo)
      expect(Todo.pending).not_to include(@completed_todo)
    end
  end
end