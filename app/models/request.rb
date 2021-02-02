class Request < ApplicationRecord
    belongs_to :donor, optional: true
    belongs_to :requester, optional: true

    scope :has_requester, -> { where(requester_id: true) }
    scope :has_donor, -> { where(donor_id: true) }
    scope :outstanding, -> { where(fulfilled: false) }
    scope :fulfilled, -> { where(fulfilled: true) }
    

end
