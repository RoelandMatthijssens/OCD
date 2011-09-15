module ActionLogsHelper
	def log action
		a = ActionLog.new()
		a.user = current_user
		a.action = action
		a.save!
	end
end
