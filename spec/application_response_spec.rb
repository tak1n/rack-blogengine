require 'spec_helper'

module Rack
	module Blogengine
		describe ApplicationResponse do
			describe ".call" do
				it "should return response" do
					ApplicationResponse.call(env)
				end
			end
		end
	end
end