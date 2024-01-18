class Api::V1::ActorsController < ApplicationController
    before_action :set_actor, only: [:show, :update, :destroy]
  
    def index
      actors = Actor.all
      render json: actors
    end
  
    def show
      render json: @actor
    end
  
    def create
      actor = Actor.new(actor_params)
      if actor.save
        render json: actor, status: :created
      else
        render json: actor.errors, status: :unprocessable_entity
      end
    end
  
    def update
      if @actor.update(actor_params)
        render json: @actor
      else
        render json: @actor.errors, status: :unprocessable_entity
      end
    end
  
    def destroy
      @actor.destroy
      head :no_content
    end
  
    private
  
    def set_actor
      @actor = Actor.find_by(id: params[:id])
      unless @actor
        render json: { error: 'Actor not found' }, status: :not_found
      end
    end
  
    def actor_params
      params.require(:actor).permit(:name, :country)
    end
end