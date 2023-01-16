module UserProfileHelper
    def new_settlement_button_should_be_shown_for(user, user_profile)
        
        true # This method is not finished
        
        # if user.isAttorney? && user_profile.user.isAdjuster?
        #     true
        # elsif user_profile.user.isAttorney? && user.isAdjuster?
        #     true
        # else
        #     false
        # end
    end

    def empty_active_settlement_message
        if @owner == current_user
            "You do not have any active settlements. Click <a href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner == current_user.organization
            "#{@owner.name} does not have any active settlements. Click <a href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner.in?(current_user.members)
            "#{@owner.name} does not have any active settlements."
        elsif current_user.isMember?
            "You do not have any active settlements with #{@owner.name}. Click <a href='#{settlement_new_path}'>here</a> to start one.</p>".html_safe
        else
            "You do not have any active settlements with #{@owner.name}."
        end
    end
end
