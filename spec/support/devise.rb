include Warden::Test::Helpers

RSpec.configure do |config|
    config.shared_context_metadata_behavior = :apply_to_host_groups
end

RSpec.shared_context "devise", :shared_context => :metadata do
    before(:each) do
        Warden.test_mode!
    end
  
    after(:each) do
        Warden.test_reset!
    end

    def sign_in(user)
        login_as(user, scope: :user)
    end

    def sign_out
        logout(:user)
    end
end

RSpec.configure do |config|
    config.include_context "devise", :include_shared => true
    config.after :suite, type: :system do
        fork do
            %x|rails db:migrate:reset RAILS_ENV=test|
            puts "Test database was reset because the following command is automatically run after every test suite."
            puts "\n\t\t\trails db:migrate:reset RAILS_ENV=test\n\n"
            puts "This is triggered by the after(:all) hook in spec/support/devise.rb"
            exit
        end
    end
end