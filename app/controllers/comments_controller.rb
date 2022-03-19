class CommentsController < ApplicationController
    before_action :authenticate_user!

    def create
        release_form = ReleaseForm.find(params[:release_form_id])
        comment = release_form.comments.build(comment_params)
        release_form.update_attribute(:status, "Rejected")
        if comment.save
            redirect_to(release_form_index_path) 
        end
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
