module IconsHelper

    # def visa_card_icon(args=nil)
    #     "<div style='max-width: 100px;'>#{
    #         File.open("app/assets/images/visa.svg") do |file|
    #             raw file.read
    #         end
    #     }</div>".html_safe
    # end

    def credit_card_icon(options = {})
        asset = Rails.application.assets.find_asset("#{options[:issuer].present? ? options[:issuer] : "credit_card"}.svg")
    
        if asset
          file = asset.source.force_encoding("UTF-8")
          doc = Nokogiri::HTML::DocumentFragment.parse file
          svg = doc.at_css "svg"
          svg["class"] = options[:class] if options[:class].present?
          #svg["viewbox"] = "0 0 1000 1000" # options[:viewbox] if options[:viewbox].present?
          svg["style"] = "width: 39px; height: 25px;" # options[:style] if options[:style].present?
          svg["id"] = "#{options[:issuer]}_card_icon" 
          svg["type"] = "card_icon" # options[:style] if options[:style].present?
        else
          doc = "<!-- SVG #{filename} not found -->"
        end
    
        raw doc
      end
end