require 'stringio'
require 'logger'

$log_format = proc do |serverity, time, progname, msg|
  "[#{serverity}] - [#{time}] - #{msg}\n"
end

def refresh_log
  $strio = StringIO.new
  $logger = Logger.new($strio)
  $logger.formatter = $log_format
  $logger.datetime_format = '%Y-%m-%d %H:%M:%S.%L'
end

Before do |scenario|
  refresh_log
  @test_step_count = 0
  @test_steps = Array.new
  scenario.test_steps.each do |r|
    if r.name != 'AfterStep hook'
      @test_steps << r
    end
  end

  puts 'Scenario running: ' + scenario.name
end

After do |scenario|

  if scenario.failed?
    puts scenario.exception
    puts scenario.exception.message
    time = Time.now.strftime('%Y%m%d%H%M%S')
    file_path = File.expand_path('./output/screenshot') + '/' + time.to_s + '.png'
    page.save_screenshot file_path
    embed(file_path, 'image/png', 'Scenario_Failed_Screenshot')
    puts 'Scenario failed: ' + scenario.name
  else
    puts 'Scenario succeeded: ' + scenario.name
  end
  add_browser_logs
  puts $strio.string
end

def add_browser_logs
  @auth_c = nil
  @console_log = page.driver.browser.manage.logs.get(:browser).map {|line| [line.level, line.message]}

  @auth_c = page.driver.browser.manage.cookie_named("auth_cookie")[:value] unless page.driver.browser.manage.cookie_named("auth_cookie") == nil
  @console_log unless @console_log == nil

  puts "logging_time = #{Time.now} \n" + "current_url = #{Capybara.current_url.to_s} \n" + "auth_cookie = #{@auth_c} \n" + "console_log = #{@console_log}"
end


AfterStep do |scenario|
  $logger.info(@test_steps[@test_step_count].name)
  @test_step_count += 1
end