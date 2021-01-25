class Request < ApplicationRecord
    belongs_to :donor, optional: true
    # validates :donor_id, presence: true, allow_nil: true

    belongs_to :requester, optional: true
    # validates :requester_id, presence: true, allow_nil: true
    scope :has_requester?, -> { where(requester_id: exists) }
    scope :has_donor?, -> { where(donor_id: exists) }

    def fulfilled?
        self.fulfilled == true
    end

    def outstanding?
        self.fulfilled == false
    end

end
