class RequestersController < ApplicationController
    has_many :requests
    has_many :donors, through: :requests
end
