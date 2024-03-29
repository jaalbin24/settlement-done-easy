module UserProfileHelper
    def new_settlement_button_should_be_shown_for(user, user_profile)
        if user == user_profile.user
            true
        elsif member_role_name(user) == member_role_name(user_profile.user)
            
        end
        true # This method is not finished
        
        # if user.isAttorney? && user_profile.user.isAdjuster?
        #     true
        # elsif user_profile.user.isAttorney? && user.isAdjuster?
        #     true
        # else
        #     false
        # end
    end

    def add_bank_account_button_should_be_shown_for(user, user_profile)
        if user == user_profile.user
            true
        else
            false
        end
    end

    def empty_active_settlement_message
        if @owner == current_user # If the visitor is the owner
            "You do not have any active settlements. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner == current_user.organization # If the visitor is one of the owners members
            "#{sanitize @owner.name} does not have any active settlements. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.".html_safe
        elsif @owner.in?(current_user.members) || @owner.organization == current_user.organization # If the visitor is a member of the same organization or the owners organization
            "#{sanitize @owner.name} does not have any active settlements."
        elsif (current_user.isAttorney? || current_user.isLawFirm?) && (@owner.isAttorney? || @owner.isLawFirm?)
            "You cannot have settlements with #{sanitize @owner.name} because they are #{sanitize indefinite_articleize(word: @owner.role.downcase)}"
        elsif (current_user.isAdjuster? || current_user.isInsuranceCompany?) && (@owner.isAdjuster? || @owner.isInsuranceCompany?)
            "You cannot have settlements with #{sanitize @owner.name} because they are #{sanitize indefinite_articleize(word: @owner.role.downcase)}"
        elsif current_user.isMember?
            "You do not have any active settlements with #{sanitize @owner.name}. Click <a data-test-id='empty_active_settlement_link' href='#{settlement_new_path}'>here</a> to start one.</p>".html_safe
        else
            "You do not have any active settlements with #{sanitize @owner.name}."
        end
    end

    def empty_bank_account_message
        if @owner == current_user # If the visitor is the owner
            "You do not have any bank accounts. Click <a data-test-id='empty_active_settlement_link' href='#{bank_account_new_path(continue_path: user_profile_show_path(section: :bank_accounts))}'>here</a> to add one.".html_safe
        elsif @owner.in?(current_user.members) || @owner.organization == current_user.organization || @owner == current_user.organization # If the visitor is a member of the same organization or the owners organization or one of the owners members
            "#{sanitize @owner.name} does not have any bank accounts."
        else
            "Bank accounts owned by #{sanitize @owner.name} are private."
        end
    end

    def whats_next_action_messages
        whats_next_messages = {
            ready_for_payment: {
                submit_value: true,
                message_text: "%settlement% %is% ready for payment",
            },
            needs_attr_approval_from: {
                submit_value: @owner.public_id,
                message_text: "%settlement% %needs% your approval",
            },
            needs_document: {
                submit_value: true,
                message_text: "%settlement% %needs% a document",
            },
            needs_document_approval_from: {
                submit_value: @owner.public_id,
                message_text: "%document% %needs% your approval",
            },
            needs_signature: {
                submit_value: :true,
                message_text: "%document% %needs% a signature",
            }
        }
        arr = whats_next_messages.keys.map do |k|
            case k
            when :ready_for_payment
                next if @owner.isAttorney? # Attorneys should not be prompted to send payments. As part of SDE's design, attorneys fundamentally cannot send money, so they should never be prompted to.
                count = @settlements.ready_for_payment.count
            when :needs_attr_approval_from
                count = @settlements.needs_attr_approval_from(@owner).count
            when :needs_document
                count = @settlements.needs_document.count
            when :needs_document_approval_from
                count = @documents.needs_approval_from(@owner).count
            when :needs_signature
                count = @documents.unsigned.needs_signature.count
            else
                raise StandardError.new "Unhandled message type in the whats next card: #{k}"
            end
            next if count == 0
            message_text = whats_next_messages[k][:message_text]
                .sub('%settlement%', count == 1 ? 'A settlement' : "#{count} settlements")
                .sub('%document%', count == 1 ? 'A document' : "#{count} documents")
                .sub('%needs%', count == 1 ? 'needs' : 'need')
                .sub('%is%', count == 1 ? 'is' : 'are')
            "<form type='search' action='#{settlement_search_path}' accept-charset='UTF-8' method='post'>
                <input type='hidden' name='authenticity_token' value='#{form_authenticity_token}' autocomplete='off'>
                <input value='#{whats_next_messages[k][:submit_value]}' autocomplete='off' type='hidden' name='#{k}' id='#{k}'>
                <button type='submit' class='border-0 border-bottom list-group-item list-group-item-action d-flex justify-content-between align-items-center gap-2 link-dark px-3'>
                    <i class='fa-solid fa-circle-exclamation text-warning h5 m-0'></i>
                    <h6 class='m-0 me-auto' data-test-id='#{k}_message'>#{message_text}</h6>
                    <i class='m-0 fa-solid text-muted fa-chevron-right'></i>
                </button>
            </form>"
        end
        arr.join("\n").html_safe
    end

    def whats_next_wait_messages
        whats_next_messages = {
            payment_sending: {
                message_text: "%payment% to be sent",
            },
            document_approval: {
                message_text: "%document% to be approved",
            },
            attr_approval: {
                message_text: "%settlement% to be approved",
            },
        }

        "<div class='list-group-item' id='whats_next_wait_list'>
            <h5 class='text-muted'>Wait for...</h5>
            <ul class='list-unstyled m-0'>
                #{
                    wait_messages = whats_next_messages.keys.map do |k|
                        case k
                        when :payment_sending
                            next if @owner.isAdjuster? # Adjusters should not be prompted to wait on a payment to be sent. If there is a payment to be sent, it should be in an action whats next message.
                            count = @settlements.ready_for_payment.count
                        when :document_approval
                            count = @settlements.needs_document_approval_from_anyone_except(@owner).count
                        when :attr_approval
                            count = @settlements.needs_attr_approval_from_anyone_except(@owner).count
                        else
                            raise StandardError.new "Unhandled message type in the whats next card: #{k}"
                        end
                        next if count == 0
                        message_text = whats_next_messages[k][:message_text]
                            .sub('%settlement%', "#{count} #{'settlement'.pluralize(count)}")
                            .sub('%document%', "#{count} #{'document'.pluralize(count)}")
                            .sub('%payment%', "#{count} #{'payment'.pluralize(count)}")
                        "<li data-test-id='awaiting_#{k}_message'>
                            <p class='m-0'>#{message_text}</p>
                        </li>"
                    end
                    wait_messages.join("\n")
                }
            </ul>
        </div>".html_safe

    end
end
