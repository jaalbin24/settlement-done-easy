module ApplicationCable
    class Connection < ActionCable::Connection::Base
        identified_by :current_user

        def connect
            puts "🌐🌐🌐 CONNECTING..."
            self.current_user = find_verified_user
        end

        private

        def find_verified_user # this checks whether a user is authenticated with devise
            
            if verified_user = env['warden'].user
                puts "🌐🌐🌐 User verified!"
                verified_user
            else
                puts "🌐🌐🌐 User rejected!"
                reject_unauthorized_connection
            end
        end
    end
end
