class UsersController < ApplicationController
    has_one :borrower
    has_one :donor
end
