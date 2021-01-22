class SessionsController < ApplicationController
    validates :password, presence: true, unless: -> { from_omniauth? }
    validates :password, length: { minimum: 6 }, unless: -> { from_omniauth? }
end