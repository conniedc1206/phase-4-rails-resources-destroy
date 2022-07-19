class BirdsController < ApplicationController

  # GET /birds
  def index
    birds = Bird.all
    render json: birds
  end

  # POST /birds
  def create
    bird = Bird.create(bird_params)
    render json: bird, status: :created
  end

  # GET /birds/:id
  def show
    bird = Bird.find_by(id: params[:id])
    if bird
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id
  def update
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(bird_params)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # PATCH /birds/:id/like
  def increment_likes
    bird = Bird.find_by(id: params[:id])
    if bird
      bird.update(likes: bird.likes + 1)
      render json: bird
    else
      render json: { error: "Bird not found" }, status: :not_found
    end
  end

  # DELETE /birds/:id
  def destroy
    # Find a bird using the ID from the route params
    bird = Bird.find_by(id: params[:id])
    # Remove it from the database with bird.destroy
    # :no_content will give a 204 status code, indicating that the server has successfully fulfilled the request and that there is no content to send in the response. 
    if bird
      bird.destroy
      head :no_content
      # render json: {} # json-server handles a successful delete request by sending an empty object
    else
      render json: {error: "Bird not found"}, status: :not_found
    end
  end

  private

  def bird_params
    params.permit(:name, :species, :likes)
  end

end
