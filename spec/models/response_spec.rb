describe Response do
  
  context "email digests" do
    before(:each) do
      @event = instance_double(Event, data: { "text" => "some data" } )
      @trigger = instance_double(Trigger, action: 'digest')
    end

    it "sends send_email_digest message to ResponseMailer" do
      response = Response.new(trigger: @trigger, events: [@event]).send! 
    end

  end
end
