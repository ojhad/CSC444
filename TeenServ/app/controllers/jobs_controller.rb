class JobsController < ApplicationController

	def index
		@jobs = Job.all
		puts @jobs
		puts 'in the index'
	end

	def new
	end
end
