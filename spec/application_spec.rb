require 'spec_helper'

module Rack
  module Blogengine
  	class ApplicationTester
  		attr_accessor :env

  		def call(env)
    		# check that env == @env and whatever else you need here
    		@env = env
    		[200, {}, '']
  		end
	end


  	describe Application do
  		let(:app) { ->(env) { [200, env, "app"] } }

  		before(:each) do
  			@apptester = ApplicationTester.new
  			@apptester.env = app

  			@application = Application.new(@apptester)
  		end

  		describe "#call" do
  			it "should return an repsonse Array" do
  				@application.call(@apptester.env)
  			end
  		end
  	end
  end
end