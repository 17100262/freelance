class TimerJob < ApplicationJob
  queue_as :default

  def perform(res,status)
    if status == "LIVE" and res.status == "LIVE"
      res.update(status: "CANCELLED")
      res.job.user.increment!(:balance,@reservation.amount)
      res.job.update(status: "LIVE")
    end
  end
end
