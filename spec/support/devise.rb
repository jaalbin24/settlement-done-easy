include Warden::Test::Helpers

RSpec.configure do |r|
    r.shared_context_metadata_behavior = :apply_to_host_groups
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

RSpec.configure do |r|
    r.include_context "devise", :include_shared => true
end