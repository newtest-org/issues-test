# Language: Ruby, Level: Level 3
require_relative 'reporter'

class Browser
  extend Capybara::DSL

  def self.navigate(url)
    visit url
    Reporter.log_step("info",'launch url',"navigate to #{url}")
    page.windows[0].maximize
  end

  def self.get_title
    page.title
    Reporter.log_step("info",'browser title',"Browser Title - #{page.title}")
  end

  def self.has_title(page_title)
    page.has_title? page_title
  end

  def self.switch_to_new_window
    window = page.driver.browser.window_handles
    if window.size > 1
      page.driver.browser.switch_to.window(window.last)
    else
      Reporter.log_step "Fail","Switch Window","New window is not open or present"
    end
  end

  def self.switch_to_first_window
    page.driver.browser.switch_to.window(page.driver.browser.window_handles.first)
  end

  def self.close_current_window
    page.driver.browser.close
  end

  def self.previous_page
    page.go_back
  end
end
