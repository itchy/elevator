class CucumberGreeter
  def message
    "Hello Cucumber!"
  end
end  

Given /^a greeter$/ do
  @greeter = CucumberGreeter.new
end

When /^I send it the greet message$/ do
  @message = @greeter.message
end

Then /^I should see "([^'']*)"$/ do |greeting|
  @message.should == greeting
end    