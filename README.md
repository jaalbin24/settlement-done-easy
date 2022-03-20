# README

To run SDE, follow these instructions...

1. Clone the repository into your local machine using "git clone [SSH link]". A folder called "settlement-done-easy" will be created. Navigate into that folder using the command "cd settlement-done-easy"

2. Run the following commands in this order
    1) bundle install
    2) yarn install
    3) yarn add bootstrap jquery popper.js
    4) yarn add bootswatch
    5) yarn add autosize
    6) rails db:migrate:reset db:seed
    7) rails server

3. In your URL, type "localhost:3000" and press enter. The page should load for a while then show the application.

4. You're set up!

Before taking to production...
delete this section of code from release_form.rb 
    ```before_validation do
        if !self.pdf.attached?
            self.pdf.attach(io: StringIO.new(Prawn::Document.new().render), filename: 'dummy_file.pdf')
        end 
    end```

Ideas for improvement:
```
-Adding support for assistive technologies (screen-readers for the blind, etc.)
```
