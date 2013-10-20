class UsersController < ApplicationController
  def tryout
    create_guest_user unless current_user
    redirect_to projects_path
  end

  def create
  end

  private

  def create_guest_user
    user = User.create(:email => "guest##{Time.now.to_i}#{rand(99)}@example.com", :guest => true)
    user.save :validate => false 
    sign_in(user)
  end
end
