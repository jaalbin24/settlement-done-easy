class ApplicationRecord < ActiveRecord::Base
    self.abstract_class = true

    validates :public_id, inclusion: {in: -> (i) {[i.public_id_was]}, message: 'ID cannot be changed.'}, on: :update


    before_create do
        self.public_id = GeneratePublicId.for(self)
    end

    def to_param
        public_id
    end
end
