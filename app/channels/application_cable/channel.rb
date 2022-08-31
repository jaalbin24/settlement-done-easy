module ApplicationCable
    class Channel < ActionCable::Channel::Base
        identified_by :current_user

        def connect
            if user_signed_in?
                self.current_user = current_user
            end
        end
    end
end
