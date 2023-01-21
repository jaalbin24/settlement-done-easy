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


    

    def whats_next_messages
        whats_next_messages = {
            needs_attr_approval_from: {
                submit_value: @owner.public_id,
                message_text: "%n_settlements_need% your approval",
            },
            needs_document: {
                submit_value: true,
                message_text: "%n_settlements_need% a document",
            },
            ready_for_payment: {
                submit_value: true,
                message_text: "%n_settlements_are% ready for payment",
            },
            needs_document_approval_from: {
                submit_value: @owner.public_id,
                message_text: "%n_settlements_need% document approval",
            },
            needs_signature: {
                submit_value: :true,
                message_text: "%n_documents_need% a signature",
            }
        }
        arr = whats_next_messages.keys.map do |k|
            case k
            when :needs_attr_approval_from
                count = @settlements.needs_attr_approval_from(@owner).count
                message_text = whats_next_messages[k][:message_text].sub('%n_settlements_need%', "#{count == 1 ? 'A settlement needs' : "#{count} settlements need"}")
            when :needs_document
                count = @settlements.needs_document.count
                message_text = whats_next_messages[k][:message_text].sub('%n_settlements_need%', "#{count == 1 ? 'A settlement needs' : "#{count} settlements need"}")
            when :ready_for_payment
                count = @settlements.ready_for_payment.count # && owner.isAdjuster?
                message_text = whats_next_messages[k][:message_text].sub('%n_settlements_are%', "#{count == 1 ? 'A settlement is' : "#{count} settlements are"}")
            when :needs_document_approval_from
                count = @documents.needs_approval_from(@owner).count
                message_text = whats_next_messages[k][:message_text].sub('%n_settlements_need%', "#{count == 1 ? 'A settlement needs' : "#{count} settlements need"}")
            when :needs_signature
                count = @documents.unsigned.needs_signature.count
                message_text = whats_next_messages[k][:message_text].sub('%n_documents_need%', "#{count == 1 ? 'A document needs' : "#{count} documents need"}")
            else
                raise StandardError.new "Unhandled message type in the whats next card: #{k}"
            end
            next if count == 0
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
end
