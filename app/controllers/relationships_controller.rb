class RelationshipsController < ApplicationController
  def create
    @relationship = Relationship.new(relationship_params)

    respond_to do |format|
      if @relationship.save
        format.html { redirect_to user_path(@relationship.followed_id), notice: "You're now following this user!" }
        format.js { redirect_to user_path(@relationship.followed_id), notice: "You're now following this user!" }
      else
        format.js { render user_path(params[:follower_id]), notice: "Error in follow attempt" }
      end
    end
  end

  def destroy
    Relationship.find_by(relationship_params).destroy

    respond_to do |format|
      format.html { redirect_to user_path(params[:followed_id]), notice: "You've unfollowed this user!" }
      format.js { redirect_to user_path(params[:followed_id]), notice: "You've unfollowed this user!" }
    end
  end

  private

    def relationship_params
      params.permit(:user_id, :followed_id)
    end
end
