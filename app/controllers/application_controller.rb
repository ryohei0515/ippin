class ApplicationController < ActionController::Base
  include SessionsHelper

  def hello
    #render html: "hello, world!"
    print "test"
  end
end
