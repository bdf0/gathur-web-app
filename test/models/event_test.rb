require 'test_helper'

class EventTest < ActiveSupport::TestCase
	
	def setup
    @user = users(:michael)

    @event = @user.events.build(title: "Sample Event", location: "Sample Location", description: "This is a sample event.", start_time: Time.new(2000), end_time: Time.new(2001), public: false)
  end

  test "should be valid" do
    assert @event.valid?
  end

  test "user id should be present" do
    @event.user_id = nil
    assert_not @event.valid?
  end
  
  test "title should be present" do
    @event.title = "     "
    assert_not @event.valid?
  end
  
  test "location should be present" do
    @event.location = "     "
    assert_not @event.valid?
  end
  
  test "start time should be present" do
    @event.start_time = nil
    assert_not @event.valid?
  end
  
  test "end time should be present" do
    @event.end_time = nil
    assert_not @event.valid?
  end
  
  test "end time should be after start time" do
    @event.start_time = Time.new(2000)
    @event.end_time = Time.new(1999)
    assert_not @event.valid?
  end
  
  test "earliest events should appear first" do
  	previous_event = nil
  	Event.all.each do |event|
  		assert event.start_time >= previous_event.start_time unless previous_event.nil?
  		previous_event = event
  	end
  end
  
  test "associated events should be destroyed" do
    @user.save
    assert_difference 'Event.count', -1 do
      @user.destroy
    end
  end

end

