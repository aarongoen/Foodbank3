class RequestsController < ApplicationController
    belongs_to :donor
    belongs_to :requester 
end
