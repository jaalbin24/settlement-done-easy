class SignaturesController < ApplicationController


    def create
        puts allowed_params
        document = Document.find_by!(public_id: params[:doc_public_id])
        signature = document.signatures.build(
            signer_email: allowed_params[:signer_email],
            corner1_x: allowed_params[:corner1_x],
            corner1_y: allowed_params[:corner1_y],
            corner2_x: allowed_params[:corner2_x],
            corner2_y: allowed_params[:corner2_y],
        )
        if signature.save
            flash[:primary] = {
                heading: "Your signature request was sent.",
                message: "Your signature request was sent to <span class='fw-bold'>#{helpers.sanitize signature.signer_email}</span>. You will be notified when their signature is completed."
            }
        else
            flash[:danger] = {
                heading: "Your signature request was not sent.",
                message: "There was an error when your signature request was being sent. Try again later."
            }
        end
        redirect_to @continue_path
    end

    private

    def allowed_params
        params.require(:signature).permit(
            :corner1_x,
            :corner1_y,
            :corner2_x,
            :corner2_y,
            :signer_email,
        )
    end
end
