class CommentsController < ApplicationController
    # before_action :authenticate_user!

    def create
        document = Document.find(params[:document_id])
        comment = document.comments.build(comment_params)
        comment.author = current_user
        if comment.save
            redirect_back(fallback_location: root_path)
        else
            flash[:error] = "Failed to post comment! #{comment.errors.full_messages.inspect}"
            redirect_back(fallback_location: root_path)
        end
    end

    def comment_params
        params.require(:comment).permit(:content)
    end
end
