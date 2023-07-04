class TodosController < ApplicationController

    skip_before_action :verify_authenticity_token, only: :create
    skip_before_action :verify_authenticity_token, only: :update
    skip_before_action :verify_authenticity_token, only: :destroy
    before_action :set_todo, only: [:show, :update, :destroy]
  
    def index
        @todo = Todo.all 
        render json: @todos
    end
  
    def show
        render json: @todo
    end
  
    def create
      @todo = Todo.new(todo_params)
      if @todo.save
        render json: @todo
      else
        render json: @todo.errors, status: :unprocessable_entity
      end
    end
  
    def update
        if @todo.update(todo_params)
            render json: @todo
        else
            render json: @todo.errors, status: :unprocessable_entity
        end        
    end
  
    def destroy
        @todo.destroy
    end
  
    private
  
    def set_todo
      @todo = Todo.find(params[:id])
    end
  
    def todo_params
      params.require(:todo).permit(:id, :title, :completed)
    end
  end
  