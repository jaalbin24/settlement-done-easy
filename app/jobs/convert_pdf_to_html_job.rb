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
                    document.html.attach(io: File.open(Rails.root.join("tmp/storage/document_#{key}.html")), filename: "#{document.pdf.filename.base}.html", identify: false, content_type: 'text/html')
                    File.remove(Rails.root.join("tmp/storage/document_#{key}.html"))
                end
            end
        rescue => e
            puts "||||||||||||||||||||||||||||||||||||||||||||||||||| #{e.message} |||||||||||||||||||||||||||||||||||||||||||||||||||"
        end
    end
end
