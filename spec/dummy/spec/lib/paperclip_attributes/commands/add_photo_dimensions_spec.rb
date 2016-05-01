require "rails_helper"

RSpec.describe PaperclipAttributes::Commands::AddPhotoDimensions do
  describe "#perform" do
    context "with image content type" do
      before do
        @user = User.new(avatar: fixture_file_upload("bukowski.jpg", "image/png"))
        described_class.new(@user, :avatar).perform
      end

      it "copies image with and height on model" do
        expect(@user.avatar_width).to eq(600)
        expect(@user.avatar_height).to eq(794)
      end
    end

    context "with non image content type" do
      before do
        @user = User.new(avatar: fixture_file_upload("video.mp4", "video/mp4"))
        described_class.new(@user, :avatar).perform
      end

      it "does not save image with and height" do
        expect(@user.avatar_width).to be_nil
        expect(@user.avatar_height).to be_nil
      end
    end
  end
end
