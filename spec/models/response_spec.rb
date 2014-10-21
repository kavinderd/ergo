describe Response do
  
  context "email digests" do
    before(:each) do
      @event = instance_double(Event, data: { "text" => "some data" } )
      @trigger = instance_double(Trigger, action: 'email_digest')
    end

    it "sends send_email_digest message to ResponseMailer" do
      inst = double("mailer")
      allow(inst).to receive(:deliver)
      mailer = class_double(ResponseMailer).as_stubbed_const
      expect(mailer).to receive(:email_digest).with(["some data"]).and_return(inst)
      response = Response.new(trigger: @trigger, events: [@event]).send! 
    end

  end
end
