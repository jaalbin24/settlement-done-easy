# require 'rtesseract'
# require 'pdftoimage'
# require 'rmagick'

# if Rails.env.development?
#     namespace :detect do
#         task :signatures do |task, args|
#             # convert pdf to image
#             PDFToImage.open('dummy_document.pdf') do |page|
#                 page.save("dummy_document.png")
#             end

#             # read image with RMagick
#             img = Magick::Image.read("dummy_document.png").first

#             # initialize rtesseract with english language
#             rtesseract = RTesseract.new("dummy_document.png", lang: "eng")

#             # search for the word 'signature' in the image
#             signatures = rtesseract.to_box.select {|i| i[:word].downcase == 'signature'}

#             # create a drawing object
#             draw = Magick::Draw.new

#             # set the fill color for the rectangle
#             draw.fill("red")
#             draw.fill_opacity(0.2)

#             # set the stroke width for the rectangle

#             # draw a rectangle around the signature block
#             signatures.each do |i|
#                 draw.rectangle(i[:x_start]-10, i[:y_start]-10, i[:x_end]+10, i[:y_end]+10)
#             end

#             # draw the rectangle on the image
#             draw.draw(img)

#             # write the image with the rectangle to a file
#             img.write("dummy_document.png")
#         end
#     end
# end


