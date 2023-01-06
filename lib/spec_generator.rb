module SpecGenerator
    module Printer

    end

    class SystemSpec
        attr_accessor :file_string, :level, :tab

        def initialize(args=nil)
            self.file_string = ""
            self.level = 0
            self.tab = "    "
            if block_given?
                yield self
                SystemSpec.create_file({
                    filename: "#{args[:name]}.rb",
                    file_string: self.file_string
                })
            end
        end
        # returns a string of the RSpec describe-block
        def describe(title, &block)
            self.file_string += "require 'rails_helper'\n\nRSpec.describe \"#{title}\" do\n"
            self.level += 1
            self.file_string += "#{self.tab*self.level}include_context 'devise'\n"
            yield
            self.level -= 1
            self.file_string += "end\n"
        end
        # returns a string of an RSpec context-block
        def context(title, &block)
            self.file_string += "#{self.tab*self.level}context \"#{title}\" do\n"
            self.level += 1
            yield
            self.level -= 1
            self.file_string += "#{self.tab*self.level}end\n"
        end
        # returns a string of an RSpec it-block
        def it(title, &block)
            self.file_string += "#{self.tab*self.level}it \"#{title}\" do\n"
            self.level += 1
            yield.gsub(self.tab, "").split("\n").each do |line|
                if line.end_with?("|", "do")
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                    self.level += 1
                elsif line.end_with?("end")
                    self.level -= 1
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                else
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                end
            end
            self.level -= 1
            self.file_string += "#{self.tab*self.level}end\n"
        end
        # returns a string of an RSpec before-block hook
        def before(type, &block)
            self.file_string += "#{self.tab*self.level}before :#{type} do\n"
            self.level += 1
            yield.gsub(self.tab, "").split("\n").each do |line|
                if line.end_with?("|", "do")
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                    self.level += 1
                elsif line.end_with?("end")
                    self.level -= 1
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                else
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                end
            end
            self.level -= 1
            self.file_string += "#{self.tab*self.level}end\n"
        end
        # returns a string of an RSpec after-block hook
        def after(type, &block)
            self.file_string += "#{self.tab*self.level}after :#{type} do\n"
            self.level += 1
            yield.gsub(self.tab, "").split("\n").each do |line|
                if line.end_with?("|", "do")
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                    self.level += 1
                elsif line.end_with?("end")
                    self.level -= 1
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                else
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                end
            end
            self.level -= 1
            self.file_string += "#{self.tab*self.level}end\n"
        end
        # Used for printing regular text to the eventual file
        def text
            yield.gsub(self.tab, "").split("\n").each do |line|
                if line.end_with?("|", "do")
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                    self.level += 1
                elsif line.end_with?("end")
                    self.level -= 1
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                else
                    self.file_string += "#{self.tab*self.level}#{line}\n"
                end
            end
        end
        # returns a string of a comment box
        def self.comment_header(args=nil)
            lines = [
                "This file was automatically generated.",
                "Instead of editing this file, edit the generator file then run the following command",
                "",
                "rails generate_specs:system"
            ]

            width = lines.max_by(&:length).length
            height = lines.size
            capper = "# #{'='*width} #"
            empty_line = "# #{' '*width} #"

            output = "#{capper}\n#{empty_line}\n"
            lines.each do |line|
                output += "# #{line}#{' '*(width - line.length)} #\n"
            end
            output += "#{empty_line}\n#{capper}\n\n"
            output
        end

        def self.create_file(args=nil)
            Dir.chdir "#{Pathname.new(__FILE__).parent.parent}/spec/system/"
            if File.exist?("AUTO_GENERATED_#{args[:filename]}")
                puts "WARNING: A file spec/system/#{args[:filename]} already exists!"
                puts "Overwrite? (y/n)"
                input = STDIN.gets.strip
                unless input == 'y'
                    puts "Canceled"
                    return
                end
            end
            Dir.chdir "#{Pathname.new(__FILE__).parent.parent}/spec/system/"
            File.open("AUTO_GENERATED_#{args[:filename]}", "w+") do |file|
                file.write SystemSpec.comment_header(generator_file_location: "spec/generators")
                file.write args[:file_string]
            end
            puts "Generated file AUTO_GENERATED_#{args[:filename]}"
        end

        def self.generate_all_specs(args=nil)
            generator_files = Dir.glob("#{Rails.root.join('spec', 'generators')}/*.rb")
            Dir.chdir "#{Rails.root.join("spec", "generators")}"
            generator_files.each_with_index do |generator_file, i|
                puts "Generating file #{i+1}/#{generator_files.size} ..."
                system "ruby #{generator_file}"
            end
        end
    end
end