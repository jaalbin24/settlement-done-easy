module SettlementsHelper
    def settlement_summary
        if @settlement.claimant_name.nil?
            "#{number_to_currency @settlement.amount}"
        else
            "#{number_to_currency @settlement.amount} for #{@settlement.claimant_name}"
        end
    end

    def settlement_timeline
        list_items = {
            started: "<li class='%active%' data-test-id='settlement_started_milestone'>
                <div><i class='m-0 fa-solid fa-flag-checkered'></i></div>
                <p class='m-0'>Settlement started</p>
            </li>",
            details_approved: "<li class='%active%' data-test-id='details_approved_milestone'>
                <div><i class='m-0 fa-solid fa-thumbs-up'></i></div>
                <p class='m-0'>Details approved</p>
            </li>",
            documents_approved: "<li class='%active%' data-test-id='documents_approved_milestone'>
                <div><i class='m-0 fa-solid fa-thumbs-up'></i></div>
                <p class='m-0'>Documents approved</p>
            </li>",
            documents_signed: "<li class='%active%' data-test-id='documents_signed_milestone'>
                <div><i class='m-0 fa-solid fa-pen-fancy'></i></div>
                <p class='m-0'>Documents signed</p>
            </li>",
            payment_sent: "<li class='%active%' data-test-id='payment_sent_milestone'>
                <div><i class='m-0 fa-solid fa-dollar-sign'></i></div>
                <p class='m-0'>Payment sent</p>
            </li>",
            completed: "<li class='%active%' data-test-id='settlement_completed_milestone'>
                <div><i class='m-0 fa-solid fa-star'></i></div>
                <p class='m-0'>Settlement completed</p>
            </li>",
        }
        completed_milestones = [:started]
        incomplete_milestones = [:details_approved, :documents_approved, :documents_signed, :payment_sent, :completed]
        if @settlement.attribute_reviews.approved.count == 2
            incomplete_milestones.delete :details_approved
            completed_milestones.push :details_approved
        end
        if @settlement.documents.count == 0
            incomplete_milestones.delete :documents_approved
            incomplete_milestones.delete :documents_signed
        else
            if @settlement.documents.approved.count == @settlement.documents.count
                incomplete_milestones.delete :documents_approved
                completed_milestones.push :documents_approved
            end
            if @settlement.documents.needs_signature.count == 0
                incomplete_milestones.delete :documents_signed
            elsif @settlement.documents.signed == @settlement.documents.needs_signature
                incomplete_milestones.delete :documents_signed
                completed_milestones.push :documents_signed
            end
        end
        if @settlement.completed?
            incomplete_milestones.delete :payment_sent
            incomplete_milestones.delete :completed
            completed_milestones.push :payment_sent
            completed_milestones.push :completed
        elsif @settlement.has_processing_payment?
            incomplete_milestones.delete :payment_sent
            completed_milestones.push :payment_sent
        end

        ul = []

        completed_milestones.each do |m|
            ul.push list_items[m].sub('%active%', 'active')
        end
        incomplete_milestones.each do |m|
            ul.push list_items[m].sub('%active%', '')
        end
        "<div class='timeline-container mt-2'>
            <ul class='timeline w-75 mx-auto'>
                #{ul.join("\n")}
            </ul>
        </div>".html_safe
    end
end
