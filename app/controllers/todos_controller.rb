class TodosController < ApplicationController
  before_action :set_todo, only: [ :show, :edit, :update, :destroy ]

  def index
    @todos = Todo.all
    
    # Apply search filter if query parameter is present
    if params[:query].present?
      @todos = @todos.where("title LIKE ? OR description LIKE ?", "%#{params[:query]}%", "%#{params[:query]}%")
    end
    
    # Apply status filter if specified
    if params[:filter] == 'pending'
      @todos = @todos.pending
    elsif params[:filter] == 'completed'
      @todos = @todos.completed
    end
    
    # Apply final ordering
    @todos = @todos.order(created_at: :desc)
  end

  def show
    # @todo is set by before_action
    respond_to do |format|
      format.html
      format.json { render json: @todo }
      format.react { render :react_show }
    end
  end

  def new
    @todo = Todo.new
  end

  def create
    @todo = Todo.new(todo_params)

    if @todo.save
      redirect_to @todo, notice: "Todo was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    # @todo is set by before_action
  end

  def update
    if @todo.update(todo_params)
      redirect_to @todo, notice: "Todo was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url, notice: "Todo was successfully deleted."
  end

  private

  def set_todo
    @todo = Todo.find(params[:id])
  end

  def todo_params
    params.require(:todo).permit(:title, :description, :completed)
  end
end
