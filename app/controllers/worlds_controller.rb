class WorldsController < ApplicationController
  def run
    @world = World.instance
    @message = @world.run
    respond_to do |format|
      format.html
    end
  end
end
