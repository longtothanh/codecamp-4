module Users
  class InformationController < ApplicationController
    before_action :authenticate_user!
    
    def information
      @user = current_user
    end
  end
end
