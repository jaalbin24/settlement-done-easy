module DocumentGenerator
    include ActionView::Helpers::NumberHelper 
    # This^ is included for the number_to_currency method

    def generate_document_for_settlement(settlement)
        pdf = Prawn::Document.new(:margin => [30,90,30,90], filename: "#{settlement.claim_number}_release.pdf") # top, right, bottom, left
        pdf.default_leading 0
        pdf.font_size(12)
        pdf.font "Times-Roman"
        pdf.text "#{settlement.claim_number}", align: :right
        pdf.move_down 20
        pdf.text "#{settlement.insurance_agent.organization.business_name}", align: :center, style: :bold
        pdf.move_down 15
        pdf.text "FULL RELEASE OF ALL INJURY CLAIMS AND DEMANDS", align: :center, style: :italic
        pdf.move_down 15
        y_position = pdf.cursor
        pdf.bounding_box([0, y_position], width: 90) do
            pdf.text "Claim Number:"
            pdf.move_down 3
            pdf.text "Policy Number:"
            pdf.move_down 3
            pdf.text "Policy Holder:"
        end
        pdf.bounding_box([100, y_position], width: 200) do
            pdf.text "#{settlement.claim_number}"
            pdf.move_down 3
            if settlement.policy_number != nil
                pdf.text "#{settlement.policy_number}"
            else
                pdf.text "P1-23456789"
            end
            pdf.move_down 3
            pdf.text "#{settlement.defendant_name}"
        end
        pdf.move_cursor_to 590
        pdf.default_leading 0
        pdf.stroke_horizontal_rule
        pdf.move_down 10
        pdf.text "Known by all these presents that I/we, #{settlement.claimant_name}, for and in consideration of the sum of #{amount_humanized(settlement.amount).upcase} (#{number_to_currency(settlement.amount.to_f, delimiter: ',', unit: '$')}) do hereby for myself my heirs, executors, administrators, successors and assignees any and all other persons, firms, employers, corporations, associations or partnerships, release, acquit and forever discharge #{settlement.defendant_name} and #{settlement.insurance_agent.organization.full_name} of and from any and all claims, actions, causes of actions, liens, demands, rights, damages, costs, loss of wages, expenses, and compensation, hospital and medical expenses, accrued or un-accrued claims loss of consortium, loss of support of affection, loss of services, loss of society and companionship, wrongful death on account of, or in any way growing out of, any and all known and unknown personal injuries and other damages resulting from the incident which occurred on or about #{settlement.incident_date.strftime("%B %-d, %Y")}, at #{settlement.incident_location}. However, this release in no way discharges or releases any claim for property damage including rental coverage if applicable.", align: :justify  
        pdf.move_down 7
        pdf.text "Interest on said sums, if any, shall begin to accrue 30 days from the execution of this document at the statutory rate.", align: :justify
        pdf.move_down 7
        pdf.text "It is understood that as a result of the incident described above, I/we have suffered injuries, which may or may not be permanent and progressive, and have incurred medical bills and other losses and damages, the full extent and duration of which is indefinite and uncertain. I/we realize that such losses and damages may extend into the future and have taken that into account in reaching this Agreement.", align: :justify
        pdf.move_down 7
        pdf.text "It is understood and agreed that this settlement is in full compromise of a doubtful and disputed claims as to both questions of liability and as to the nature and extent of the injuries and damages, and that neither this release, nor the payment pursuant thereto shall be construed as an admission of responsibility or of liability, such being denied.", align: :justify
        pdf.move_down 7
        pdf.text "It is further understood and agreed that the undersigned relies wholly upon the undersigned's judgment, belief and knowledge of the nature, extent, effect and duration of said injuries, damages and liability. This Release is made without relying upon any statement or representation of the party or parties hereby released or their representatives.", align: :justify
        pdf.move_down 7
        pdf.text "It is a crime to knowingly provide false, incomplete, or misleading information to an insurance company for the purpose of defrauding the company. Penalties include imprisonment, fines, and denial of insurance benefits.", align: :justify, style: :bold
        pdf.move_down 30
        pdf.stroke_horizontal_line 0, 120
        pdf.stroke_horizontal_line 130, 216
        pdf.stroke_horizontal_line 226, 346
        pdf.stroke_horizontal_line 356, 432
        y_position = pdf.cursor - 5
        pdf.bounding_box([0, y_position], width: 120) do
            pdf.text "Claimant signature"
        end
        pdf.bounding_box([130, y_position], width: 120) do
            pdf.text "Date"
        end
        pdf.bounding_box([226, y_position], width: 120) do
            pdf.text "Witness signature"
        end
        pdf.bounding_box([356, y_position], width: 120) do
            pdf.text "Date"
        end
        d = settlement.documents.create!(
            auto_generated: true,
            added_by: current_user,
        )
        d.pdf.attach(io: StringIO.new(pdf.render), filename: "#{settlement.claim_number}_release.pdf")
        return d
    end
    
    def doc_generator_user
        return User.where("role=?", "Dummy").and(User.where("email=?", "doc_generator@example.com")).first
    end

    def amount_humanized(amount)
        # returns a worded dollar amount   
        dollars = amount.floor
        cents = amount - dollars
        cents *= 100
        cents = cents.round
        humanized = dollars.humanize + " dollars and " + cents.humanize + " cents"
        return humanized
    end


end