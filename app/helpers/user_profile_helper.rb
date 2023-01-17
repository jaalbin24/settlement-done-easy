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
        if @owner == current_user # If the visitor is the owner
            "You do not have any active settlements. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner == current_user.organization # If the visitor is one of the owners members
            "#{@owner.name} does not have any active settlements. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner.in?(current_user.members) || @owner.organization == current_user.organization # If the visitor is a member of the same organization or the owners organization
            "#{@owner.name} does not have any active settlements."
        elsif (current_user.isAttorney? || current_user.isLawFirm?) && (@owner.isAttorney? || @owner.isLawFirm?)
            "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
        elsif (current_user.isAdjuster? || current_user.isInsuranceCompany?) && (@owner.isAdjuster? || @owner.isInsuranceCompany?)
            "You cannot have settlements with #{@owner.name} because they are #{indefinite_articleize(word: @owner.role.downcase)}"
        elsif current_user.isMember?
            "You do not have any active settlements with #{@owner.name}. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.</p>".html_safe
        else
            "You do not have any active settlements with #{@owner.name}."
        end
    end
end
