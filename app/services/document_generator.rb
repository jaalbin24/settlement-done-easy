module DocumentGenerator

    def generate_document_for_settlement(settlement)
        pdf = Prawn::Document.new(:margin => [30,90,30,90], filename: generated_document_file_name) # top, right, bottom, left
        pdf.font_size(11)
        pdf.font "Times-Roman"
        pdf.text "#{settlement.claim_number}", align: :right
        pdf.move_down 20
        pdf.text "#{settlement.insurance_agent.organization}", align: :center, style: :bold
        pdf.move_down 15
        pdf.text "FULL RELEASE OF ALL INJURY CLAIMS AND DEMANDS", align: :center, style: :italic
        pdf.move_down 15
        pdf.default_leading 5
        pdf.text "Claim Number:      #{settlement.claim_number}"
        pdf.text "Policy Number:     #{settlement.policy_number}"
        pdf.text "Policy Holder:     #{settlement.defendant_name}"
        pdf.default_leading 0
        pdf.stroke_horizontal_rule
        pdf.move_down 10
        pdf.text "Known by all these presents that I/we, #{settlement.plaintiff_name}, for and in consideration of the sum of #{settlement.document.settlement_amount_humanized.upcase} (#{settlement.settlement_amount_formatted}) do hereby for myself my heirs, executors, administrators, successors and assignees any and all other persons, firms, employers, corporations, associations or partnerships, release, acquit and forever discharge #{settlement.defendant_name} and #{settlement.insurance_company_name} of and from any and all claims, actions, causes of actions, liens, demands, rights, damages, costs, loss of wages, expenses, and compensation, hospital and medical expenses, accrued or un-accrued claims loss of consortium, loss of support of affection, loss of services, loss of society and companionship, wrongful death on account of, or in any way growing out of, any and all known and unknown personal injuries and other damages resulting from #{settlement.incident_description} which occurred on or about #{settlement.date_of_incident}, at #{settlement.place_of_incident}. However, this release in no way discharges or releases any claim for property damage including rental coverage if applicable.", align: :justify  
        pdf.move_down 7
        pdf.text "Interest on said sums, if any, shall begin to accrue 30 days from the execution of this document at the statutory rate.", align: :justify
        pdf.move_down 7
        pdf.text "It is understood that as a result of the accident described above, I/we have suffered injuries, which may or may not be permanent and progressive, and have incurred medical bills and other losses and damages, the full extent and duration of which is indefinite and uncertain. I/we realize that such losses and damages may extend into the future and have taken that into account in reaching this Agreement.", align: :justify
        pdf.move_down 7
        pdf.text "It is understood and agreed that this settlement is in full compromise of a doubtful and disputed claims as to both questions of liability and as to the nature and extent of the injuries and damages, and that neither this release, nor the payment pursuant thereto shall be construed as an admission of responsibility or of liability, such being denied.", align: :justify
        pdf.move_down 7
        pdf.text "It is further understood and agreed that the undersigned relies wholly upon the undersigned's judgment, belief and knowledge of the nature, extent, effect and duration of said injuries, damages and liability. This Release is made without relying upon any statement or representation of the party or parties hereby released or their representatives.", align: :justify
        pdf.move_down 7
        pdf.text "It is a crime to knowingly provide false, incomplete, or misleading information to an insurance company for the purpose of defrauding the company. Penalties include imprisonment, fines, and denial of insurance benefits.", align: :justify, style: :bold
        pdf.stroke_horizontal_line 0, 173
        pdf.move_down 7
        pdf.stroke_horizontal_line 203, 261
        pdf.move_down 7
        pdf.stroke_horizontal_line 291, 464
        pdf.move_down 7
        pdf.stroke_horizontal_line 494, 552

        settlement.document.pdf.attach(io: StringIO.new(pdf.render), filename: generated_document_file_name)
    end

    def dollar_amount_humanized(amount)
        # returns a worded dollar amount   
        dollars = amount.floor
        cents = amount - dollars
        cents *= 100
        cents = cents.round
        humanized = dollars.humanize + " dollars and " + cents.humanize + " cents"
        return humanized
    end


end