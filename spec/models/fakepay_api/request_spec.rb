require 'rails_helper'

RSpec.describe FakepayApi::Request do

  subject {described_class.new(body: body, headers: headers, message: message)}

  let(:body) {{"amount" => 123456}}
  let(:headers) {{"headers" => "some headers"}}
  let(:message) {:make_purchase}

  # this is a dumb test -> should be better
  describe "#make_request!" do
    it "makes a request" do
      expect(subject).to receive(:make_request!)

      subject.make_request!
    end
  end


end