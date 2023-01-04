if Rails.env.development?
    require 'spec_generator'
    namespace :generate_specs do
        task :system do |task, args|
            SpecGenerator::SystemSpec.generate_all_specs
        end
    end
end