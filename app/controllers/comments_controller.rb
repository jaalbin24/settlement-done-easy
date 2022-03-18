class CommentsController < ApplicationController
    def create
        release_form = ReleaseForm.find(params[:release_form_id])
        comment = release_form.comments.build(comment_params)
        if comment.save
            redirect_back(fallback_location: root_path)
        end
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
