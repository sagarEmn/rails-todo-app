require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  describe 'GET #index' do
    it 'returns a successful response' do
      get :index
      expect(response).to be_successful
    end

    it 'assigns all todos to @todos' do
      todo1 = Todo.create(title: 'First Todo')
      todo2 = Todo.create(title: 'Second Todo')
      get :index
      expect(assigns(:todos)).to include(todo1, todo2)
    end

    context 'with filter params' do
      before do
        @completed_todo = Todo.create(title: 'Completed Todo', completed: true)
        @pending_todo = Todo.create(title: 'Pending Todo', completed: false)
      end

      it 'filters by pending status' do
        get :index, params: { filter: 'pending' }
        expect(assigns(:todos)).to include(@pending_todo)
        expect(assigns(:todos)).not_to include(@completed_todo)
      end

      it 'filters by completed status' do
        get :index, params: { filter: 'completed' }
        expect(assigns(:todos)).to include(@completed_todo)
        expect(assigns(:todos)).not_to include(@pending_todo)
      end
    end

    context 'with search query' do
      before do
        @matching_todo = Todo.create(title: 'Find me', description: 'This is searchable')
        @non_matching_todo = Todo.create(title: 'Ignore me', description: 'Nothing to see')
      end

      it 'filters todos by search term' do
        get :index, params: { query: 'find' }
        expect(assigns(:todos)).to include(@matching_todo)
        expect(assigns(:todos)).not_to include(@non_matching_todo)
      end
    end
  end

  describe 'GET #show' do
    let(:todo) { Todo.create(title: 'Test Todo') }

    it 'returns a successful response' do
      get :show, params: { id: todo.id }
      expect(response).to be_successful
    end

    it 'assigns the requested todo to @todo' do
      get :show, params: { id: todo.id }
      expect(assigns(:todo)).to eq(todo)
    end
  end

  describe 'POST #create' do
    context 'with valid parameters' do
      let(:valid_params) { { todo: { title: 'New Todo', description: 'Test description' } } }

      it 'creates a new Todo' do
        expect {
          post :create, params: valid_params
        }.to change(Todo, :count).by(1)
      end

      it 'redirects to the created todo' do
        post :create, params: valid_params
        expect(response).to redirect_to(Todo.last)
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { { todo: { title: '', description: 'Test description' } } }

      it 'does not create a new Todo' do
        expect {
          post :create, params: invalid_params
        }.to_not change(Todo, :count)
      end

      it 're-renders the new template' do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end