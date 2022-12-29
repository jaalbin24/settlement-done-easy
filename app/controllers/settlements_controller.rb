class SettlementsController < ApplicationController
    include DsEnvelope
    include DocumentGenerator
    before_action :authenticate_user!
    before_action :ensure_organization_is_activated, only: [:new, :create]

    def ensure_organization_is_activated
        unless current_user.organization.activated?
            flash[:primary] = "You cannot start a settlement until #{current_user.organization.full_name}'s account is activated."
            redirect_to root_path
        end
    end

    def new
        if current_user.isAttorney?
            @settlement = Settlement.new
            @users = User.all_adjusters
            render :new
        elsif current_user.isAdjuster?
            @settlement = Settlement.new
            @users = User.all_attorneys
            render :new
        else
            handle_invalid_request
        end
    end

    def create
        begin
            partner = User.find_by!(public_id: params[:partner_id])
        rescue
            handle_invalid_request
            return
        end
        # HTML in the "new settlement" page can be modified to bypass browser-based param control and cause errors to be thrown
        # server-side. This begin-rescue block handles cases where the user-select field was sabotaged client-side.
        if current_user.isAttorney?
            attorney = current_user
            adjuster = partner
        elsif current_user.isAdjuster?
            attorney = partner
            adjuster = current_user
        end
        settlement_creation_params = {
            started_by: current_user,
            claim_number: settlement_params[:claim_number],
            policy_number: settlement_params[:policy_number],
            amount: settlement_params[:amount],
            policy_holder_name: settlement_params[:policy_holder_name],
            claimant_name: settlement_params[:claimant_name],
            incident_date: settlement_params[:incident_date],
            incident_location: settlement_params[:incident_location],
            attorney: attorney,
            adjuster: adjuster
        }
        settlement = Settlement.new(settlement_creation_params)
        if settlement.save
            flash[:primary] = "Started a new settlement with #{partner.full_name}! Click <a href=#{settlement_show_path(settlement)}>here<a> to view it."
            redirect_to settlement_show_url(settlement)
        else
            flash.now[:error] = "#{settlement.errors.full_messages.inspect}"
            render :new
        end
    end

    def show
        begin
            @settlement = Settlement.find_by!(public_id: params[:id])
            @attr_review_by_current_user = @settlement.attribute_reviews.by(current_user).first
        rescue => e
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
            handle_invalid_request
            return
        end
    end

    def destroy
        begin
            settlement = Settlement.find_by!(public_id: params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.destroy
        flash[:primary] = "Settlement canceled!"
        redirect_to root_path
    end

    def update
        begin
            settlement = Settlement.find_by!(public_id: params[:id])
        rescue
            handle_invalid_request
            return
        end
        if settlement.locked?
            flash[:primary] = "This settlement cannot be modified right now because it is locked. No changes were made."
        else
            begin
                settlement.update(settlement_params)
                flash[:primary] = "Settlement updated."
            rescue SafetyError::SafetyError => e
                flash[:primary] = e.message
            rescue
                flash[:error] = "Settlement could not be updated. Try again later."
            end
        end
        redirect_back(fallback_location: root_path)
    end

    def complete
        begin
            settlement = Settlement.find_by!(public_id: params[:id])
        rescue
            handle_invalid_request
            return
        end
        settlement.completed = true
        settlement.save
        flash[:success] = "Settlement completed!"
        redirect_back(fallback_location: root_path)
    end

    def generate_document
        begin
            settlement = Settlement.find_by!(public_id: params[:id])
        rescue
            handle_invalid_request
            return
        end
        begin
            document = generate_document_for_settlement(settlement)
            document.save!
            flash[:primary] = "Generated new document! Click <a href=#{document_show_path(document)}>here</a> to view it."
        rescue SafetyError::SafetyError => e
            flash[:primary] = e.message
        rescue
            flash[:primary] = "There was a problem generating the document. Please try again later."
            puts "⚠️⚠️⚠️ ERROR: #{e.message}"
        end
        redirect_back(fallback_location: root_path)
    end

    def completed_index
        if current_user.isAttorney?
            @settlements = Settlement.where("attorney_id=?", user.id).and(Settlement.where("completed=?", true)).all
        elsif current_user.isAdjuster?
            @settlements = Settlement.where("adjuster_id=?", user.id).and(Settlement.where("completed=?", true)).all
        elsif current_user.isLawFirm?
            attorney_id_array = User.where(organization_id: user.id).pluck(:id)
            @settlements = Settlement.where(attorney_id: attorney_id_array).and(Settlement.where("completed=?", true)).all
        elsif current_user.isInsuranceCompany?
            agent_id_array = User.where(organization_id: user.id).pluck(:id)
            @settlements = Settlement.where(adjuster_id: agent_id_array).and(Settlement.where("completed=?", true)).all
        end  
    end

    def settlement_params
        params.require(:settlement).permit(
            :claim_number,
            :policy_number,
            :amount,
            :policy_holder_name,
            :claimant_name,
            :incident_date,
            :incident_location
        )
    end
end
