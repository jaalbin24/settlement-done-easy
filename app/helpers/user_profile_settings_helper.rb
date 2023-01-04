module UserProfileSettingsHelper
    def user_can_access_profile_resource?(user, profile, resources=nil)
        puts "=====================visitor=#{user.name}"
        puts "=====================owner=#{profile.user.name}"
        puts "=====================resources=#{resources}"
        # Users always have full access to their own profile.
        # Organizations always have full access to their members' profiles.
        if user == profile.user || user == profile.user.organization
            puts "||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||||"
            return true
        end

        if resources.nil?
            return false
        else
            resources.each do |e|
                if profile.settings.read_attribute("show_#{e.to_s}_to_public")
                    puts "profile.settings.read_attribute(\"show_#{e.to_s}_to_public\")=#{profile.settings.read_attribute("show_#{e.to_s}_to_public")}"
                    next
                elsif profile.settings.read_attribute("show_#{e.to_s}_to_members_only") && user.isMember?
                    if profile.user.organization == user.organization || profile.user == user.organization
                        puts "profile.settings.read_attribute(\"show_#{e.to_s}_to_members_only\")=#{profile.settings.read_attribute("show_#{e.to_s}_to_members_only")}"
                        next
                    else
                        return false
                    end
                else
                    return false
                end
            end
        end
        return true
    end
end
