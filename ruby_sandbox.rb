begin_trx;

ScheduledJob.where("run_in_test = true").each{ |sj|
  delay_minutes = 10;

  minutes = sj.minutes + delay_minutes ;
  if minutes > 59;
    minutes -= 60;
    sj.minutes = minutes;
    hours = sj.hours + 1;
    if hours > 23;
      hours -=24;
      sj.hours = hours;
    end
  end
  sj.save;
};

commit;

begin_trx;

ScheduledJob.where("run_in_test = true").all.update("enabled", true);

commit;