require "rails_helper"

RSpec.describe PaperclipAttributes::Commands::GetChangedPaperclipColumns do
  describe "#initialize" do
    it "raises error trying to pass a non ActiveRecord instance as param" do
      expect { described_class.new({}) }.to raise_error(
        PaperclipAttributes::Error::InvalidActiveRecordModel)
    end
  end

  describe "#perform" do
    let(:avatar) { fixture_file_upload("bukowski.jpg", "image/png") }

    context "without modifications on paperclip columns" do
      before { @cmd = described_class.new(User.new) }

      it "returns empty array" do
        expect(@cmd.perform).to be_empty
      end
    end

    context "with changed paperclip columns" do
      before do
        user = User.new(avatar: avatar)
        @cmd = described_class.new(user)
      end

      it "returns array with modifications on paperclip columns" do
        expect(@cmd.perform).to contain_exactly(:avatar)
      end
    end
  end
end
