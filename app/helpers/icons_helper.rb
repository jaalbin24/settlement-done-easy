module IconsHelper


    # Possible args icon helpers are
    #   - color: A string of a color hex code like '#ffffff'
    #   - size: An integer representing the desired size of the icon in pixels.

    def x_icon(args={})
        render inline: Rails.root.join("app", "assets", "images", "x_icon.svg.erb").read, locals: {color: args[:color], size: args[:size]}
    end

    def pen_icon(args={})
        render inline: Rails.root.join("app", "assets", "images", "pen_icon.svg.erb").read, locals: {color: args[:color], size: args[:size]}
    end

    def download_icon(args={})
        render inline: Rails.root.join("app", "assets", "images", "download_icon.svg.erb").read, locals: {color: args[:color], size: args[:size]}
    end

    private
end