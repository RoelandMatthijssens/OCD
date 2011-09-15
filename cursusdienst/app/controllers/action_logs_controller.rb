class ActionLogsController < ApplicationController

	def index
		@title = t(:all_action_logs, :scope => "titles" )
		@action_logs = ActionLog.all()
	end
end
