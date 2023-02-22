require 'rmagick'

class ConvertPdfToImageJob < ApplicationJob
    queue_as :internal

    # The document model might not be fully created when this job is first queued, so
    # we let a few retries happen.
    retry_on ActiveJob::DeserializationError, wait: 5.seconds, attempts: 5

    def perform(document)
        pages = Magick::ImageList.new.from_blob(document.pdf.download) do |settings|
            settings.quality = 100
            settings.density = 200
        end
        pages.each_with_index do |page, i|
            page.format = 'jpeg'
            document.pages.attach(io: StringIO.new(page.to_blob), filename: "#{document.pdf.filename.base}_page#{i}.jpeg")
        end
    end
end
