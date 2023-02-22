class ConvertPdfToHtmlJob < ApplicationJob
    queue_as :internal

    retry_on IOError

    def perform(document)
        begin
            if document.pdf.attached?
                unless document.html.attached?
                    key = SecureRandom.alphanumeric(32)
                    pdf_path = ActiveStorage::Blob.service.path_for(document.pdf.key)
                    Kristin.convert(pdf_path, "tmp/storage/document_#{key}.html")
                    raw_doc = File.open("tmp/storage/document_#{key}.html") {|f| Nokogiri::HTML(f)}
                    
                    cleaned_up_doc = Nokogiri::HTML::Document.new
                    cleaned_up_doc.root = cleaned_up_doc.create_element('html')

                    raw_doc.css('style').each do |el|
                        cleaned_up_doc.root.add_child(el.clone)
                    end

                    raw_doc.css('div[data-page-no]').each do |el|
                        cleaned_up_doc.root.add_child(el.clone)
                    end


                    document.html.attach(io: StringIO.new(cleaned_up_doc.to_html), filename: "#{document.pdf.filename.base}.html", identify: false, content_type: 'text/html')
                    
                    File.remove(Rails.root.join("tmp/storage/document_#{key}.html"))
                end
            end
        rescue => e
            puts "||||||||||||||||||||||||||||||||||||||||||||||||||| #{e.message} |||||||||||||||||||||||||||||||||||||||||||||||||||"
        end




        # Load the existing HTML file
        doc = Nokogiri::HTML(document)

        # Create a new HTML document
        new_doc = Nokogiri::HTML::Document.new
        new_doc.root = new_doc.create_element('html')

        # Copy over the original style elements
        doc.css('style').each do |style|
            new_doc.root.add_child(style.clone)
        end

        # Copy over any div elements with the attribute "data-page-no"
        doc.css('div[data-page-no]').each do |div|
            new_doc.root.add_child(div.clone)
        end

        # Save the new HTML document
        File.open('path/to/new.html', 'w') { |f| f.write(new_doc.to_html) }
    end
end
